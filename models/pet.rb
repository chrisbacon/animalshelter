require_relative('../db/sqlrunner')

class Pet
    attr_reader :entry, :name, :species, :id
    attr_accessor :owner_id, :exit
    def initialize( options )
        @name = options['name']
        @species = options['species']
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

    def adoption_status
        return "Ready for adoption!" if is_adoptable?
        return "Needs to stay a bit longer."
    end

    def save()
        #prepare optional values for SQL string
        owner_id_value = "NULL"
        owner_id_value = "#{@owner_id}" if @owner_id

        exit_value = "NULL"
        exit_value = "'#{@exit}'" if @exit

        sql = "
        INSERT INTO pets
        (name, species, entry, exit, owner_id)
        VALUES
        ('#{@name}', '#{@species}', '#{@entry}', #{exit_value}, #{owner_id_value})
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
        SET (name, species, entry, exit, owner_id)
        =
        ('#{@name}', '#{@species}', '#{@entry}', #{exit_value}, #{owner_id_value})
        WHERE id = #{@id}
        ;"

        SqlRunner.run(sql)
    end

    def owner()
        return Customer.find(@owner_id) if @owner_id
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

    def self.all()
        sql = 
        "SELECT * FROM pets;"

        result = SqlRunner.run(sql)

        return result.map { |pet| Pet.new(pet) }
    end
end