# config.ru

require 'rubygems'
require 'sinatra'

require File.dirname(__FILE__) + "/app.rb"

set :environment, ENV['RACK_ENV']

run Sinatra::Application