require_relative('../models/customer.rb')
require_relative('../models/pet.rb')

cust1 = Customer.new({'name' => 'Chris'})
cust1.save()

pet1 = Pet.new({
    'name' => 'Muffin',
    'species' => 'Cat',
    'entry' => '2016-11-19'
    })

pet1.save()

pet1.owner_id = cust1.id
pet1.exit = '2016-11-20'
pet1.update()

pet2 = Pet.new({
    'name' => 'Austin',
    'species' => 'Dog',
    'entry' => '2016-11-01'
    })

pet2.save()

pet3 = Pet.new({
    'name' => 'Peter',
    'species' => 'Rabbit',
    'entry' => '2016-11-23'
    })

pet3.save()

pet4 = Pet.new({
    'name' => 'Chocolate Chip',
    'species' => 'Guinea Pig',
    'entry' => '2016-10-31'
    })

pet4.save()

