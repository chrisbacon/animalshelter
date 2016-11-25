require_relative('../models/customer.rb')

cust1 = Customer.new({'name' => 'Chris'})
cust1.save()

pet1 = Pet.new({
    'name' => 'Muffin',
    'species' => 'Cat',
    'entry' => '2016-08-26'
    })

pet1.save()