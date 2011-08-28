<h1>Cashmachine <span><a href="https://github.com/joshellington/Cashmachine">github.com/joshellington/Cashmachine</a></span></h1> 

  <h2>Retrieves popular JSON/XML-based APIs and caches them. Requires memcached.</h2>

  <p class="border"><em>Pass type (xml, json) and/or limit as query parameters. Defaults are type=json and limit=API_DEFAULT.</em></p> 
   
  <h3>Twitter</h3> 
   
  <h4>User timelines</h4> 
   
  <p>http://localhost:9393/twitter/:USERNAME</p> 
   
  <h4>Search API</h4> 
   
  <p>http://localhost:9393/twitter/search/:QUERY</p> 
   
  <h4>Search API - Hashtag</h4> 
   
  <p>http://localhost:9393/twitter/search/hashtag/:QUERY</p> 
   
  <h3>Last.fm</h3> 
   
  <h4>Artist events</h4> 
   
  <p>http://localhost:9393/lastfm/artist/:ARTIST/events/</p> 
   
  <p><em>Make sure to pass the artist name with spaces or %20</em></p> 
   
  <h3>Facebook</h3> 
   
  <h4>Photo Album</h4> 
   
  <p>http://localhost:9393/facebook/photos/:ALBUM_ID</p> 
   
  <h3>Youtube</h3> 
   
  <h4>Playlist</h4> 
   
  <p>http://localhost:9393/youtube/playlist/:PLAYLIST_ID</p> 
   
  <h3>YQL</h3> 

  <p class="border">http://localhost:9393/yql/query/:YOUR_QUERY</p> 
   
  <h3>TODO</h3> 
   
  <ul> 
  <li>Add error support</li> 
  <li>Add expiration time parameter</li> 
  <li>Add Flickr class</li> 
  <li>Add authentication</li> 
  </ul> 