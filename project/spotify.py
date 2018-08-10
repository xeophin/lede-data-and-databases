# must likely be installed using `pip install requests_oauthlib`
from requests_oauthlib import OAuth2Session
from oauthlib.oauth2 import BackendApplicationClient
from requests.auth import HTTPBasicAuth

# Dictionary of the form {'client_id': 'xxx', 'client_secret': 'xxx'}, 
# imported from another file that is ignored by git so it won't be uploaded 
# to GitHub.
from project.apikeys import SPOTIFY_CREDENTIALS


def get_authenticated_session():
  """
  This gets the proper credentials and tokens to query the Spotify API, 
  according to the `Spotify guide`_ and the guide from requests_oauthlib_.
  
  .. _Spotify guide: https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow
  .. _requests_oauthlib: https://requests-oauthlib.readthedocs.io/en/latest/oauth2_workflow.html#backend-application-flow
  
  
  :return: The authenticated OAuth session – use as you would `requests`
  """

  # set up the authentication
  auth = HTTPBasicAuth(SPOTIFY_CREDENTIALS['client_id'], SPOTIFY_CREDENTIALS[
    'client_secret'])

  # Define the client based on the credentials
  client = BackendApplicationClient(**SPOTIFY_CREDENTIALS)

  # Set up the session
  session = OAuth2Session(client=client)

  # Get the token to use in this session
  session.fetch_token(token_url='https://accounts.spotify.com/api/token',
                      auth=auth,
                      data={'grant_type': 'client_credentials'})
  return session