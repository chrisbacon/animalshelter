get '/pets' do
    @pets = Pet.all()
    erb(:"pets/index", :layout => :layout) do
        erb(:"pets/card")
    end
end

get '/pets/filter/:id' do
    id = params['id'].to_i
    @selected = Hash.new(false)
    @selected[id] = true

    @all_species = Species.all()
    @species = @all_species.select { |s| s.id == id }[0]

    @pets = Pet.find_all_by_species(id)
    erb(:"pets/filter", :layout => :layout) do
        erb(:"pets/card")
    end
end

get '/pets/new' do
    @species = Species.all()
    erb(:"pets/new")
end

post '/pets' do
    params['entry'] = Date.today.to_s
    new_pet = Pet.new(params)
    new_pet.save()
    redirect to '/pets'
end

get '/pets.json' do
    content_type :json
    pets = Pet.all()
    pets.map!{ |pet| pet.to_json }
    return pets.to_json
end

get '/pets/:id' do
    @pet = Pet.find(params['id'].to_i)
    erb(:"pets/show", :layout => :layout) do
        erb(:"pets/card")
    end
end

get '/pets/:id/delete' do
    Pet.delete(params['id'].to_i)
    redirect to '/pets'
end

get '/pets/:id/adopt' do
    @pet = Pet.find(params['id'].to_i)
    @customers = Customer.all()
    erb(:"pets/adopt")
end

post '/pets/:id' do
    pet = Pet.find(params['pet_id'].to_i)
    customer = Customer.find(params['customer_id'].to_i)
    pet.owner_id = customer.id
    pet.exit = Date.today
    pet.update()
    redirect to '/pets'
end