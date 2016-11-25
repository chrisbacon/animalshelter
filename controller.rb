require('sinatra')
require('sinatra/contrib/all')
require_relative('models/pet')
require_relative('models/customer')

get '/pets' do
    @pets = Pet.all()
    erb(:index)
end

get '/pets/:id/adopt' do
    @pet = Pet.find(params['id'])
    @customers = Customer.all()
    erb(:adopt)
end