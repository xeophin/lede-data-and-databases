"""
Save data to CSV, so we can read that in within blender.
"""
import pg8000
import pandas as pd

conn = pg8000.connect(database="esc", user="km")
cursor = conn.cursor()

query = '''
SELECT * FROM finalists f JOIN contests c ON f.contest_id = c.id
'''
cursor.execute(query)
array = cursor.fetchall()

columns = [
  'artist',
  'country',
  'points',
  'performance_order',
  'ranking',
  'broadcaster',
  'composers',
  'contest_id',
  'final_type',
  'id',
  'song',
  'writers',
  'spotify_id',
  'acousticness',
  'danceability',
  'duration',
  'energy',
  'instrumentalness',
  'key',
  'liveness',
  'loudness',
  'mode',
  'speechiness',
  'tempo',
  'valence',
  'contest_id_2',
  'img_src',
  'location',
  'name',
  'url',
  'year'
]

df = pd.DataFrame(list(array), columns=columns)

df.to_csv('all_songs.csv', index=False)
