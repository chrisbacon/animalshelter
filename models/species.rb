require_relative('../db/sqlrunner')

class Species
	attr_reader :name

	def initialize( options )
		@name = options['name']
		
		@id = options['id'] if options['id']
	end
	
	def self.all()
		sql = "
		SELECT * FROM species
		;"

		result = SqlRunner(sql)

		return result.map { |s| Species.new(s) }
	end
end