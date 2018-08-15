import pg8000

from project.apikeys import SPOTIFY_CREDENTIALS
from project.common import normalise_tag_name, create_uuid

conn = pg8000.connect('km', database='esc')
cursor = conn.cursor()

#### ARTIST GENRES ######
# %% load the artist list
performer_query = '''
SELECT DISTINCT a.name, p.artist_id 
FROM performers p 
  JOIN artists a ON a.id = p.artist_id 
'''
cursor.execute(performer_query)
performers = cursor.fetchall()

# %% Setup spotipy with the correct credentials and a token
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_credentials_manager = SpotifyClientCredentials(**SPOTIFY_CREDENTIALS)
spotify = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# %%
# Loop through the list, search for artist on spotify, get spotify ID
for performer, uuid in performers:
  params = {
    'q': performer,
    'type': 'artist',
    'limit': 1
  }

  results = spotify.search(**params)
  if results['artists']['total'] > 0:
    first_hit = results['artists']['items'][0]
    genres = first_hit['genres']
    name = first_hit['name']
    song_id = first_hit['id']

    print('Looking for {} yielded {}, {} with genres {}'.format(
      performer,
      name, song_id, ', '.join(genres)))

    # save artist Spotify ID to database, just to be sure
    cursor.execute("UPDATE artists SET spotify_id = %s WHERE id = %s",
                   (song_id, uuid))

    # normalise genres, write to db
    for genre in genres:
      normalised_genre = normalise_tag_name(genre)
      genre_uuid = create_uuid(normalised_genre, 'internal://genre/')

      # Add the genre to the database (unless we already found it at some 
      # point, then just do nothing)
      add_to_genre_query = """
      INSERT INTO genres (id, normalised_name, name) VALUES (%s, %s, %s) ON 
      CONFLICT DO NOTHING
      """
      cursor.execute(add_to_genre_query, (genre_uuid, normalised_genre, genre))

      # Add the connection, so we know which artist has what genre.
      add_to_conn_table_query = """
      INSERT INTO genres_conn (artist_id, genre_id) VALUES (%s, %s) ON CONFLICT DO NOTHING 
      """
      cursor.execute(add_to_conn_table_query, (uuid, genre_uuid))


  else:
    print('Found nothing for {}.'.format(performer))

# Commit all the database changes back to the database
conn.commit()

# %%
########### SONG INFORMATION #################

# Load the song list
song_query = '''
SELECT id, song, artist 
FROM finalists
WHERE spotify_id IS NULL
'''

cursor.execute(song_query)
songs = cursor.fetchall()

# refresh the Spotify token
spotify = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# Loop through the list, search for the track on Spotify
# https://developer.spotify.com/documentation/web-api/reference/search/search/
for song_id, song_title, artist in songs:
  result = spotify.search('artist:{} track:{}'.format(artist, song_title),
                          limit=1)

  if result['tracks']['total'] > 0:
    spotify_track = result['tracks']['items'][0]
    print('Found {} with ID {}'.format(spotify_track['name'], spotify_track[
      'id']))

    # get attributes
    features_list = spotify.audio_features([spotify_track['id']])
    features = features_list[0]

    update_query = """
    UPDATE finalists 
    SET 
      spotify_id = %s,
      spotify_acousticness = %s,
      spotify_danceability = %s,
      spotify_duration = %s,
      spotify_energy = %s,
      spotify_instrumentalness = %s,
      spotify_key = %s,
      spotify_liveness = %s,
      spotify_loudness = %s,
      spotify_mode = %s,
      spotify_speechiness = %s,
      spotify_tempo = %s,
      spotify_valence = %s
    WHERE id = %s
    """

    cursor.execute(update_query, (
      spotify_track['id'],
      features['acousticness'],
      features['danceability'],
      features['duration_ms'],
      features['energy'],
      features['instrumentalness'],
      features['key'],
      features['liveness'],
      features['loudness'],
      features['mode'],
      features['speechiness'],
      features['tempo'],
      features['valence'],
      song_id
    ))
    conn.commit()

  else:
    print('Track {} by {} not found'.format(song_title, artist))

# https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/


# %% Close the database connection
conn.close()
