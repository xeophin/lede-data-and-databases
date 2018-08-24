import csv

import bpy

VALUE_MULTIPLICATOR = 3
FIRST_CONTEST = 1956
LAST_CONTEST = 2018

sphere_mat = bpy.data.materials['Spheres']

with open('all_songs.csv') as csvfile:
  reader = csv.DictReader(csvfile)
  for row in reader:
    print(row['artist'], row['song'])
    if row['spotify_id'] is not '':
      normalized_year = (int(row['year']) - FIRST_CONTEST) / (
          LAST_CONTEST - FIRST_CONTEST)
      location = [
        normalized_year * VALUE_MULTIPLICATOR,
        float(row['valence']) * VALUE_MULTIPLICATOR,
        float(row['energy']) * VALUE_MULTIPLICATOR
      ]

      bpyscene = bpy.context.scene

      bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=1, size=0.02,
                                                  location=location)
      
      obj = bpy.context.active_object
      obj.data.materials.append(sphere_mat)
