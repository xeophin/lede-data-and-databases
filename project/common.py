import re
import uuid
from typing import List

from slugify import slugify


def normalise_artist_names(name: str) -> str:
  """
  Normalise the artist's name, so we can compare it. This is needed since in 
  some cases, the artists are spelled differently in different years.
  
  :param name: The artists's name
  :return: The normalised version of the artist's name
  
  >>> normalise_artist_names('test')
  'test'
  >>> normalise_artist_names('Céline Dion')
  'celine-dion'
  >>> normalise_artist_names('Vince van Clef') == normalise_artist_names('Vince Van Clef')
  True
  """
  #  We're just gonna use slugify to normalise the artist name and compare 
  # against that
  return slugify(name.strip())


def get_uuid_for_artist(artist_name: str) -> uuid:
  """
  Generates the UUID for an artist name.
  :param artist_name: The (normalised) artist's name
  :return: The UUID for this artist
  
  """
  PREFIX = 'internal://artist/'
  return uuid.uuid3(
    uuid.NAMESPACE_URL,
    PREFIX + normalise_artist_names(artist_name))


def split_creators(creators: str) -> List[str]:
  """
  Split a creators list apart into its components.

  :param creators: A string of potentially several creators, separated by `, 
  & / and`.
  :return: A list of creator's names.
  """
  if creators == '-':
    return []

  pattern = r'\s*[,/&+()]+\s*|\Wand\W'
  splitted = re.split(pattern, creators)
  return splitted
