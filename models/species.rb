require_relative('../db/sqlrunner')

class Species
	attr_reader :name

	def initialize( options )
		@name = options['name']
		
		@id = options['id'] if options['id']
	end
	
	
end