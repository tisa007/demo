require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'
require  'dm-migrations'

Dir.glob("#{File.dirname(__FILE__)}/libs/*.rb") { |rb| require rb }
Dir.glob("#{File.dirname(__FILE__)}/models/*.rb") { |rb| require rb }

# just store values in cookie
# enable :sessions

# use a middware to have more functionality
use Rack::Session::Pool, :expire_after => 24*60*60
set :public, File.dirname(__FILE__) + '/public'

DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, "sqlite3:///#{File.dirname(__FILE__)}/demo.db")
DataMapper.auto_migrate!
DataMapper.auto_upgrade!

get '/' do
    erb :"home/index"
end

get '/parse' do
    erb :"parse/index", {}, {:result => nil}
end

post '/parse' do
    parser = Parser.new
    result = parser.parse params[:url]
    erb :"parse/index", {}, {:result => result}
end

get '/docs' do
    @docs = Doc.all
    erb :"doc/index"
end
get '/docs/new' do
    erb :"doc/new"
end
post '/docs/new' do
    doc = Doc.new
    doc.save
    redirect '/docs'
end
