require __dir__ + '/../models/notes.rb'

class NoteController
	def self.find(id)
		Notes.find_id(id)
	end

	def self.store(params)
		note_title = params[:note_title]
		note_body = params[:note_body]

		return false if note_title.empty? or note_body.empty?

		Notes.add(note_title, note_body)
		
		true
	end

	def self.update(params)
		id = params[:id]
		note_title = params[:note_title]
		note_body = params[:note_body]

		return false if note_title.empty? or note_body.empty?

		Notes.update_id(id, [note_title, note_body])
	end

	def self.delete(id)
		Notes.delete(id)
	end
end
