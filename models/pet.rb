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
        (name, species, entry, exit)
        VALUES
        ('#{@name}', '#{@species}', '#{@entry}', '#{@exit}')
        returning 
        ;"
    end

    
end