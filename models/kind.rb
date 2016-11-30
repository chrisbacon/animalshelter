require_relative('../db/sqlrunner')

class Kind
	attr_reader :name, :group_name, :id

	def initialize( options )
		@name = options['name']
		@group_name = options['group_name']
		@id = options['id'].to_i if options['id']
	end

	def save()
		sql = "
		INSERT INTO kinds
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
		SELECT * FROM kinds
		WHERE id = #{id}
		;"

		result = SqlRunner.run(sql)

		return Kinds.new(result[0])
	end
	
	def self.all()
		sql = "
		SELECT * FROM kinds
		;"

		result = SqlRunner.run(sql)

		return result.map { |s| Kinds.new(s) }
	end
end