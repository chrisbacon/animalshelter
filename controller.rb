require('sinatra')
require('sinatra/contrib/all')
require('date')
require_relative('models/pet')
require_relative('models/customer')

get '/pets' do
    @pets = Pet.all()
    erb(:pets)
end

get '/pets/:id/adopt' do
    @pet = Pet.find(params['id'].to_i)
    @customers = Customer.all()
    erb(:adopt)
end

get '/pets/:id' do
    @pet = Pet.find(params['id'].to_i)
    erb(:show)
end

post '/pets' do
    pet = Pet.find(params['pet_id'].to_i)
    customer = Customer.find(params['customer_id'].to_i)
    pet.owner_id = customer.id
    pet.exit = Date.today
    pet.update()
    redirect to '/pets'
end

get '/customers' do
    @customers = Customer.all()
    erb(:customers)
end