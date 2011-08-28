require 'rubygems'
require 'sinatra'
require './config/init'

t = Twitter.new
f = Facebook.new
l = LastFM.new
y = YQL.new
yt = Youtube.new
u = Utility.new

#
# Before any route is run
before do
  @path = request.env['SCRIPT_NAME']
  if params[:type] == 'json' or params[:type].nil?
    content_type 'application/json'
  else
    content_type 'text/xml'
  end
end

#
# Routes
match '/' do
  content_type :html
  erb :index
end

match '/stats/?' do
  $cache.stats.inspect
end

match '/twitter/:username/?' do
  t.user_timeline(params[:username], params[:limit], params[:type], params)
end

match '/twitter/search/:query/?' do
  t.search(params[:query], params[:limit], params[:type], params)
end

match '/twitter/search/hashtag/:query/?' do
  t.search('%23'+params[:query], params[:limit], params[:type], params)
end

match '/lastfm/artist/:artist/events/?' do
  l.event(params[:artist], params[:limit], params[:type], params)
end

match '/facebook/photos/:id/?' do
  f.photos(params[:id], params)
end

match '/youtube/playlist/:id/?' do
  content_type :json
  yt.playlist(params[:id], params[:limit], params)
end

match '/yql/query/:query' do
  y.query(params[:query], params)
end

match '/utility/clear/:id/?' do
  u.delete(params[:id])
end