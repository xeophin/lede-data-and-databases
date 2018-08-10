import pg8000

conn = pg8000.connect('km', database='esc')
cursor = conn.cursor()

# %%
myquery = '''
SELECT a.name, count(f.song)
FROM composers
       JOIN artists a ON composers.artist_id = a.id
       JOIN finalists f ON composers.song_id = f.id
WHERE f.ranking < 4
GROUP BY a.name
ORDER BY count DESC;
'''
cursor.execute(myquery)
myresult = cursor.fetchall()
for name, count in myresult[:10]:
  print('Komponist {} hat {} Beiträge'.format(name, count))

# Great, so connecting directly to the PostgreSQL data base works.

#### ARTIST GENRES ######
# %% load the artist list
performer_query = '''
SELECT DISTINCT a.name, p.artist_id 
FROM performers p 
  JOIN artists a ON a.id = p.artist_id 
'''
cursor.execute(performer_query)
performers = cursor.fetchall()

# %%
from project.spotify import get_authenticated_session

spotify = get_authenticated_session()

# %%
# Loop through the list, search for artist on spotify, get spotify ID
# https://developer.spotify.com/documentation/web-api/reference/search/search/
SPOTIFY_ENDPOINT_SEARCH = 'https://api.spotify.com/v1/search'
for performer, uuid in performers[:10]:
  params = {
    'q': performer,
    'type': 'artist'
  }

  r = spotify.get(SPOTIFY_ENDPOINT_SEARCH, params=params)
  results = r.json()
  if results['artists']['total'] > 0:
    first_hit = results['artists']['items'][0]
    genres = first_hit['genres']
    name = first_hit['name']
  
    print('Looking for {} yielded {} with genres {}'.format(
      performer,
      name, ', '.join(genres)))
  else:
    print('Found nothing for {}.'.format(performer))

# Save the list back to CSV

########### SONG INFORMATION #################

# Load the artist list

# Loop through the list, search for the track on Spotify
# https://developer.spotify.com/documentation/web-api/reference/search/search/

# https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/
