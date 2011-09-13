require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'
require File.join(File.dirname(__FILE__), 'libs/parser')

# just store values in cookie
# enable :sessions

# use a middware to have more functionality
use Rack::Session::Pool, :expire_after => 24*60*60

get '/' do
    'hello,sinatra'
end

get '/hello' do
    erb :hello
end

get '/parse' do
    erb :parse_form, {}, {:result => nil}
end

post '/parse' do
    parser = Parser.new
    result = parser.parse params[:url]
    erb :parse_form, {}, {:result => result}
end

get '/halt/:id' do
    if params[:id].to_i == 1
        'pass'
        pass
    else
        'not pass'
    end
end

get '/halt/*' do
    halt
end

=begin
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")
class Post
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :body, String
end
Post.auto_migrate! unless Post.storage_exists?
=end
