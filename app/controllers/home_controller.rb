require __dir__ + '/../models/notes.rb'

class HomeController
	def self.index
		Notes.get_all
	end
end
