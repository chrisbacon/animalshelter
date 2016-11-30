require_relative('../models/customer.rb')
require_relative('../models/pet.rb')
require_relative('../models/kind.rb')

s1 = Kind.new({'name' => 'Cat', 'group_name' => 'Cats'})
s2 = Kind.new({'name' => 'Dog', 'group_name' => 'Dogs'})
s3 = Kind.new({'name' => 'Rabbit', 'group_name' => 'Rabbits'})
s4 = Kind.new({'name' => 'Guinea Pig', 'group_name' => 'Guinea Pigs'})
s5 = Kind.new({'name' => 'Cockatiel', 'group_name' => 'Cockatiels'})

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
    'kind_id' => s1.id,
    'entry' => '2016-11-19'
    })

pet1.save()

pet1.owner_id = cust1.id
pet1.exit = '2016-11-20'
pet1.update()

pet2 = Pet.new({
    'name' => 'Austin',
    'kind_id' => s2.id,
    'entry' => '2016-11-01'
    })

pet2.save()

pet3 = Pet.new({
    'name' => 'Peter',
    'kind_id' => s3.id,
    'entry' => '2016-11-23'
    })

pet3.save()

pet4 = Pet.new({
    'name' => 'Chocolate Chip',
    'kind_id' => s4.id,
    'entry' => '2016-10-31'
    })

pet4.save()

pet5 = Pet.new({
    'name' => 'Ricardo',
    'kind_id' => s5.id,
    'entry' => '2016-10-01'
    })

pet5.save()

