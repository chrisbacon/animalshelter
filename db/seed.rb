require_relative('../models/customer.rb')
require_relative('../models/pet.rb')
require_relative('../models/species.rb')

s1 = Species.new({'name' => 'Cat'})
s2 = Species.new({'name' => 'Dog'})
s3 = Species.new({'name' => 'Rabbit'})
s4 = Species.new({'name' => 'Guinea Pig'})
s5 = Species.new({'name' => 'Cockatiel'})

s1.save()
s2.save()
s3.save()
s4.save()
s5.save()

cust1 = Customer.new({'name' => 'Chris'})
cust1.save()

cust2 = Customer.new({'name' => 'Calum'})
cust2.save()

pet1 = Pet.new({
    'name' => 'Muffin',
    'species_id' => s1.id,
    'entry' => '2016-11-19'
    })

pet1.save()

pet1.owner_id = cust1.id
pet1.exit = '2016-11-20'
pet1.update()

pet2 = Pet.new({
    'name' => 'Austin',
    'species_id' => s2.id,
    'entry' => '2016-11-01'
    })

pet2.save()

pet3 = Pet.new({
    'name' => 'Peter',
    'species_id' => s3.id,
    'entry' => '2016-11-23'
    })

pet3.save()

pet4 = Pet.new({
    'name' => 'Chocolate Chip',
    'species_id' => s4.id,
    'entry' => '2016-10-31'
    })

pet4.save()

pet5 = Pet.new({
    'name' => 'Ricardo',
    'species_id' => s5.id,
    'entry' => '2016-10-01'
    })

pet5.save()

