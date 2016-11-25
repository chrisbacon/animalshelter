require_relative('../db/sqlrunner')

class Customer
    attr_reader :name, :id
    def initialize( options )
        @name = options['name']
        @id = options['id'].to_i if options['id']
    end
    
    def save()
        sql = "
        INSERT INTO customers
        (name)
        VALUES
        ('#{@name}')
        returning *
        ;"

        result = SqlRunner.run(sql)

        @id = result[0]['id']
    end

    def adopt(pet)
        pet.owner_id = @id
        pet.update()
    end

    def self.find(id)
        sql = "
        SELECT * FROM customers
        WHERE id = #{id}
        ;"

        result = SqlRunner.run(sql)

        return Customer.new(result[0])
    end

    def self.all()
        sql = "
        SELECT * FROM customers
        ;"

        result = SqlRunner.run(sql)

        return result.map { |customer| Customer.new(customer) }
    end
end