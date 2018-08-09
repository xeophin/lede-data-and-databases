import datetime
import uuid
from random import randint

import pandas as pd
import requests
from bs4 import BeautifulSoup
from time import sleep


from project.common import normalise_artist_names, get_uuid_for_artist, \
  split_creators

# CONSTANTS
BASE_URL = 'https://eurovision.tv'
TODAY = datetime.datetime.now().strftime('%Y%m%d')

# this should help me keep track of the requests and give me an idea when I'm
#  starting to tax the system too much
request_stats = []


# %% define functions
def get_song_details(song_url):
  """
  Download song details from the detail page on eurovision.tv. This mainly 
  consists of the broadcasting company, the writers and composers.

  :param song_url: Unique URL fragment for the song
  :return: A dictionary containing the additional data
  """
  full_url = BASE_URL + song_url

  # Let's be cautious and not pelt the server with too many requests at once
  delay = randint(1, 5)
  sleep(delay)
  response = requests.get(full_url)

  if response.ok is not True:
    print('  Request for {} failed.'.format(song_url))
    print('  Status:', response.status_code)
    return {}

  #  Collect data for request statistics
  request_stat = {
    'delay': delay,
    'url': response.url,
    'status': response.status_code,
    'timestamp': datetime.datetime.now().timestamp()
  }

  request_stats.append(request_stat)

  # Get data out
  song_soup = BeautifulSoup(response.text, 'lxml')

  metadata_element = song_soup.select_one('[class*="songDetails"] + div')
  info_box_elements = metadata_element.select('div[class*="column"]')

  # Order of infoboxes:
  # - title
  # - performed by
  # - written by
  # - composed by
  # - broadcaster

  song_details = {
    'writers': info_box_elements[2].select_one('dd').text,
    'composers': info_box_elements[3].select_one('dd').text,
    'broadcaster': info_box_elements[4].select_one('dd').text
  }

  return song_details


def get_finalists(contest_url_fragement):
  """
  Function to get all contestants that reached a/the final.

  :param contest_url_fragement: URL fragment defining the contest
  :return: A list of all the finalists of this year
  """

  full_url = BASE_URL + contest_url_fragement + '/final'
  print('---------')
  print(full_url)
  response = requests.get(full_url)
  final_type = 'final'

  # Whoops, nothing to see at "/final". Let's try "/grand-final" instead
  if 200 < response.status_code < 500:
    print(response.status_code)
    full_url = BASE_URL + contest_url_fragement + '/grand-final'
    print(full_url)
    response = requests.get(full_url)
    print(response.status_code)
    final_type = 'grand final'

  contest_soup = BeautifulSoup(response.text, 'lxml')

  header_cells = contest_soup.select('table thead tr th '
                                     '.small-caps__SmallCaps-s1ooca2g-0')
  headers = [cell.text for cell in header_cells]

  finalists_rows = contest_soup.select('table tbody tr')

  finalists = []

  for finalist in finalists_rows:

    # get all cells in the row
    finalists_cells = finalist.select('td')

    # get some special cells, like the entry URL (which, strangely enough, 
    # is connected with the artist, and not the song
    song_url = finalists_cells[2].select_one('a')['href']

    # Set up the song entry
    entry = {
      'contest_id': uuid.uuid3(uuid.NAMESPACE_URL, BASE_URL +
                               contest_url_fragement),
      'final_type': final_type,
      'url': song_url,
      'id': uuid.uuid3(uuid.NAMESPACE_URL, BASE_URL + song_url)
    }

    # go through the table row and add data to the dictionary
    for i in range(len(finalist)):
      entry[headers[i]] = finalists_cells[i].text

    #  Find more data on the individual song page
    entry.update(get_song_details(song_url))

    # TODO Connect to last.fm API and look for even more data, because why not

    finalists.append(entry)

  return finalists


def fill_missing_pieces(finalist_row):
  """
  This function will use the row with missing data and request the data 
  again, filling in the blanks.

  :param finalist_row: Series
  :return: 
  """
  # get the url
  url = finalist_row.name

  # execute the finalists data retrieval function
  details = get_song_details(url)

  # use df.at[] to place data at the correct place
  for detail_tuple in details.items():
    finalists_df.at[url, detail_tuple[0]] = detail_tuple[1]


def add_artist_to_lists(song_id, artist_name, artists_table, join_table):
  """
  Normalise the artist name, generate a UUID, check whether it is already 
  part of the artists list. Add it to the list if not, otherwise just add to 
  the set of known aliases (not sure if that is necessary, but ... let's do 
  it anyway).

  Then add the artist UUID and song UUID to the respective join table (
  performer, writter, composer, etc)

  :param song_id: The ID of the song
  :param artist_name: The name of the artist, as gathered from the website
  :param artists_table: The big list of all the artists
  :param join_table: The table to add the song/artist connection to.
  :return: 
  """
  # generate the uuid of the artist
  artist_id = get_uuid_for_artist(artist_name)

  #  check if the uuid already exists in the artist list
  if artist_id in artists_table:
    # if yes, add to the set of aliases of the specific artist
    artists_table[artist_id]['aliases'].add(artist_name)

  else:
    # if no, add to the list of artists
    artists_table[artist_id] = {
      'name': artist_name,
      'normalised_name': normalise_artist_names(artist_name),
      'aliases': {artist_name}
    }

  #  add song UUID and artist UUID to performers list
  join_table.append(
    {
      'song_id': song_id,
      'artist_id': artist_id
    }
  )


def extract_artists(row):
  """
  Apply function that extracts all artists of a song.
  :param row: 
  :return: 
  """

  #  Get song performer
  add_artist_to_lists(row['id'], row['Artist'], artists_list, performers)

  # Get composers
  for composer in split_creators(row['composers']):
    add_artist_to_lists(row['id'], composer, artists_list, composers)

  # Get Writers
  for writer in split_creators(row['writers']):
    add_artist_to_lists(row['id'], writer, artists_list, writers)


# %% load contests

contests_df = pd.read_csv('project/contests-20180629.csv')

# %% slice

contests_df[(contests_df['year'] > 2007) & (contests_df['year'] < 2012)]['url']

# %% load additional finalists

finalists_list = []

counter = 0
for url in \
    contests_df[(contests_df['year'] > 2007) & (contests_df['year'] < 2012)][
      'url']:
  print('Get contest at', url)
  print('Index:', counter)
  sleep(randint(1, 5))
  finalists_list = finalists_list + get_finalists(url)
  counter = counter + 1

finalists_df = pd.DataFrame(finalists_list)

# use the url as the index as this is more useful that just numbers
finalists_df.set_index('url', inplace=True, verify_integrity=True)

# %% add in missing data

# get the lines where the requests failed and we have missing data
missing_data_slice = finalists_df[finalists_df['broadcaster'].isna()]
missing_data_slice.apply(fill_missing_pieces, axis=1)

# %% save everything
finalists_df.to_csv('project/finalists-' + TODAY + '.csv')

# %% set up empty lists for artists
# use a dict for artists, so we can "search" by UUID
artists_list = {}

# use normal lists for the artist-song-connections
performers = []
writers = []
composers = []

# %% extract artists
finalists_df.apply(extract_artists, axis=1)

# %% turn stuff into data frames and save
artists_df = pd.DataFrame.from_dict(artists_list, orient='index')

artists_df.to_csv('project/artists-' + TODAY + '.csv', index_label='id')

pd.DataFrame(performers).to_csv('project/performers-' + TODAY + '.csv',
                                index=False)
pd.DataFrame(writers).to_csv('project/writers-' + TODAY + '.csv',
                             index=False)
pd.DataFrame(composers).to_csv('project/composers-' + TODAY + '.csv',
                               index=False)
