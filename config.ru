# config.ru

require 'rubygems'
require 'sinatra'
require 'bundler'

Bundler.require

require File.dirname(__FILE__) + "/app.rb"

set :environment, ENV['RACK_ENV']

run Sinatra::Application