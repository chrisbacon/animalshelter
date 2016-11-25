require_relative('../db/sqlrunner')

class Pet
    attr_reader :entry
    def initialize( options )
        @name = options['name']
        @species = options['species']
        @entry = Date.parse(options['entry'])

        @exit = Date.parse(options['exit']) if options['exit']
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
        WHERE id = #{id};"

        result = SqlRunner.run(sql)

        return Pet.new(result[0])
    end

    def self.all()
        sql = 
        "SELECT * FROM pets;"

        result = SqlRunner.run(sql)

        return result.map { |pet| Pet.new(pet) }
    end
end