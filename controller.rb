require('sinatra')
require('sinatra/contrib/all')
require_relative('models/pet')

get '/pets' do
    @pets = Pet.all()
    erb(:index)
end