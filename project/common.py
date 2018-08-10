import re
import uuid
from typing import List, Optional

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


def create_uuid(identificator: str, prefix: Optional[str] = None) -> uuid:
  return uuid.uuid3(
    uuid.NAMESPACE_URL,
    prefix + identificator)


def get_uuid_for_artist(artist_name: str) -> uuid:
  """
  Generates the UUID for an artist name.
  :param artist_name: The (normalised) artist's name
  :return: The UUID for this artist
  
  >>> get_uuid_for_artist('Céline Dion')
  UUID('5ddcab91-0721-3997-bae0-7411c2e286ec')
  
  >>> get_uuid_for_artist('Celine Dion')
  UUID('5ddcab91-0721-3997-bae0-7411c2e286ec')
  
  """
  PREFIX = 'internal://artist/'
  return create_uuid(normalise_artist_names(artist_name), PREFIX)


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


def normalise_tag_name(tag):
  return slugify(tag, regex_pattern=re.compile(r'[^a-z]+'))
