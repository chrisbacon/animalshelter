require_relative('../db/sqlrunner')

class Pet
    def initialize( options )
        @name = options['name']
        @species = options['species']
        @entry = options['entry']

        @exit = options['exit'] if options['exit']
        @id = options['id'].to_i if options['id']
        @owner_id = options['owner_id'].to_i if options['owner_id']
    end
    
    def save()
        sql = "
        INSERT INTO pets
        (name, species, entry)
        VALUES
        ('#{@name}', '#{@species}', '#{@entry}')
        returning *
        ;"

        result = SqlRunner.run(sql)

        @id = result[0]['id']
    end

    def self.find(id)
        sql = 
        "SELECT * FROM pets
        WHERE id = #{id}"

        result = SqlRunner.run(sql)

        return Pet.new(result[0])
    end

    
end