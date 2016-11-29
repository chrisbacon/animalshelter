require_relative('../db/sqlrunner')

class Species
	attr_reader :name, :id

	def initialize( options )
		@name = options['name']
		
		@id = options['id'].to_i if options['id']
	end

	def save()
		sql = "
		INSERT INTO species
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
		SELECT * FROM species
		WHERE id = #{id}
		;"

		result = SqlRunner.run(sql)

		return Species(result[0])
	end
	
	def self.all()
		sql = "
		SELECT * FROM species
		;"

		result = SqlRunner.run(sql)

		return result.map { |s| Species.new(s) }
	end
end