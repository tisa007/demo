require 'rubygems'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'app')

disable :run
set :root, File.dirname(__FILE__)
run Sinatra::Application

