require 'newrelic_rpm'
require 'net/http'
require 'pp'
require 'uri'
require 'cobravsmongoose'
require 'json'
require 'digest/md5'
require 'memcached'
require 'rdiscount'

# API classes
require './lib/api/utility'
require './lib/api/twitter'
require './lib/api/facebook'
require './lib/api/yql'
require './lib/api/youtube'
require './lib/api/lastfm'

#
# Memcached
$cache = Memcached.new("localhost:11211")

#
# Helper functions

def base_uri
  base_uri_raw = request.env["HTTP_HOST"]+request.env["SCRIPT_NAME"]
  path = URI.parse(request.env["REQUEST_URI"]).path
  base_uri = "http://"+base_uri_raw.split(path)[0]
end

def curr_path
  base_uri_raw = request.env["HTTP_REFERER"]
end

def match(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end