get '/customers' do
    @customers = Customer.all()
    erb(:"customers/index")
end

get '/customers/new' do
    erb(:"customers/new")
end

post '/customers' do
    redirect to '/customers'
end

get '/customers/:id/delete' do
    Customer.delete(params['id'].to_i)
    redirect to '/customers'
end