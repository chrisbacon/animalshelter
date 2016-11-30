require_relative('../db/sqlrunner')

class Pet
    attr_reader :entry, :name, :kind_id, :id
    attr_accessor :owner_id, :exit
    def initialize( options )
        @name = options['name']
        @kind_id = options['kind_id'].to_i
        @entry = Date.parse(options['entry'])

        @exit = Date.parse(options['exit']) if options['exit']
        @id = options['id'].to_i if options['id']
        @owner_id = options['owner_id'].to_i if options['owner_id']
    end

    def is_adoptable_on?(date)
        minimum_stay = 10
        return (date - @entry) >= minimum_stay
    end

    def is_adoptable?
        return is_adoptable_on?(Date.today)
    end

    def save()
        #prepare optional values for SQL string
        owner_id_value = "NULL"
        owner_id_value = "#{@owner_id}" if @owner_id

        exit_value = "NULL"
        exit_value = "'#{@exit}'" if @exit

        sql = "
        INSERT INTO pets
        (name, kind_id, entry, exit, owner_id)
        VALUES
        ('#{@name}', #{@kind_id}, '#{@entry}', #{exit_value}, #{owner_id_value})
        returning *
        ;"

        result = SqlRunner.run(sql)

        @id = result[0]['id']
    end

    def update()
        return unless @id
        #prepare optional values
        owner_id_value = "NULL"
        owner_id_value = "#{@owner_id}" if @owner_id

        exit_value = "NULL"
        exit_value = "'#{@exit}'" if @exit

        sql = "
        UPDATE pets
        SET (name, kind_id, entry, exit, owner_id)
        =
        ('#{@name}', #{@kind_id}, '#{@entry}', #{exit_value}, #{owner_id_value})
        WHERE id = #{@id}
        ;"

        SqlRunner.run(sql)
    end

    def to_json()
        hash = {
            :name => @name,
            :kind_id => @kind_id,
            :entry => @entry
        }

        hash[:exit] = @exit if @exit
        hash[:id] = @id if @id
        hash[:owner_id] = @owner_id if @owner_id

        return hash.to_json
    end

    def owner()
        return Customer.find(@owner_id) if @owner_id
    end

    def kind()
        return Kind.find(@kind_id) if @kind_id
    end

    def self.find(id)
        sql = 
        "SELECT * FROM pets
        WHERE id = #{id};"

        result = SqlRunner.run(sql)

        return Pet.new(result[0])
    end

    def self.find_by_owner(id)
        sql = 
        "SELECT * FROM pets
        WHERE owner_id = #{id};"

        result = SqlRunner.run(sql)

        return result.map { |pet| Pet.new(pet) }
    end

    def self.find_all_by_species(id)
        sql ="
        SELECT * FROM pets
        WHERE species_id = #{id}
        ;"

        result = SqlRunner.run(sql)

        return result.map { |pet| Pet.new(pet) }
    end

    def self.all()
        sql = 
        "SELECT * FROM pets;"

        result = SqlRunner.run(sql)

        return result.map { |pet| Pet.new(pet) }
    end

    def self.delete(id)
        sql = "
        DELETE FROM pets
        WHERE id = #{id}
        ;"

        SqlRunner.run(sql)
    end
end