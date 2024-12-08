require __dir__ + '/../database/database.rb'

class Notes
	@@db_conn = Database.start

	def self.get_all
		@@db_conn.execute('select rowid, * from notes')
	end

	def self.find_id(id)
		note = @@db_conn.execute('select rowid, * from notes where rowid=?', [ id ])
		(note.empty?) ? note : note[0]
	end
	
	def self.add(note_title, note_body)
		note = {
			title: note_title,
			body: note_body
		}
		
		@@db_conn.execute('insert into notes values (?, ?)', [ note[:title], note[:body] ])
	end

	def self.update_id(id, values)
		note = {
			title: values[0],
			body: values[1]
		}

		@@db_conn.execute('update notes set title=?, body=? where rowid=?', [ note[:title], note[:body], id ])
	end
	
	def self.delete(id)
		@@db_conn.execute('delete from notes where rowid=?', [ id ])
	end
end
