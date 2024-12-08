require 'sqlite3'

class Database
	@@connection = nil

	def self.start
		unless @@connection
			@@connection = SQLite3::Database.new(__dir__ + "/project.db")
			@@connection.results_as_hash = true
		end
		@@connection
	end
end
