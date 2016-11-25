require('sinatra')
require('sinatra/contrib/all')
require_relative('models/pet')

get '/' do
    @pets = Pet.all()
    erb(:index)
end