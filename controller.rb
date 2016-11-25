require('sinatra')
require('sinatra/contrib/all')
require_relative('models/pet')

get '/' do
    erb(:index)
end