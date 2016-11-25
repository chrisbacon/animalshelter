require('sinatra')
require('sinatra/contrib/all')
require_relative('models/pet')
require_relative('models/customer')

get '/pets' do
    @pets = Pet.all()
    erb(:index)
end

get '/pets/:id/adopt' do
    @pet = Pet.find(params['id'].to_i)
    @customers = Customer.all()
    puts @customers
    erb(:adopt)
end

post '/pets/' do
    pet = Pet.find(params['pet_id'].to_i)
    
end