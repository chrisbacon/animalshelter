require_relative('../db/sqlrunner')

class Species
	attr_reader :name, :group_name, :id

	def initialize( options )
		@name = options['name']
		@group_name = options['group_name']
		@id = options['id'].to_i if options['id']
	end

	def save()
		sql = "
		INSERT INTO species
		(name, group_name)
		VALUES
		('#{@name}', '#{@group_name}')
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

		return Species.new(result[0])
	end
	
	def self.all()
		sql = "
		SELECT * FROM species
		;"

		result = SqlRunner.run(sql)

		return result.map { |s| Species.new(s) }
	end
end