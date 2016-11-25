require_relative('../db/sqlrunner')

class Customer

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

    def self.find(id)
        sql = "
        SELECT * FROM customers
        WHERE id = #{id}
        ;"

        result = SqlRunner.run(sql)

        return Customer.new(result[0])
    end
end