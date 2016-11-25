require('minitest/autorun')
require('minitest/rg')
require('date')
require_relative('../models/pet.rb')

class TestPet < Minitest::Test
    def setup()
        @pet = Pet.find(1)            
    end
    
    def test_pet_has_entry_date_in_date_format
        test_date = Date.new(2016, 8, 26)
        assert_equal(test_date, @pet.entry)
    end
    
end