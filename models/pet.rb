require_relative('../db/sqlrunner')

class Pet
    attr_reader :entry, :name, :species, :id
    attr_accessor :owner_id, :exit
    def initialize( options )
        @name = options['name']
        @species = options['species']
        @entry = Date.parse(options['entry'])

        @exit = nil
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

    def update()
        return unless @id
        sql = "
        UPDATE pets
        SET (owner_id)
        =
        (#{@owner_id})
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

    def self.all()
        sql = 
        "SELECT * FROM pets;"

        result = SqlRunner.run(sql)

        return result.map { |pet| Pet.new(pet) }
    end
end