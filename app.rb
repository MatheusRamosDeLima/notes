require 'sinatra'

# controllers
require __dir__ + '/app/controllers/home_controller.rb'
require __dir__ + '/app/controllers/note_controller.rb'

# config
set :bind, '192.168.1.6'
set :views, Proc.new { File.join(root, 'app/views') }
set :public_folder, Proc.new { File.join(root, 'public') }

# routes
get '/' do
	notes = HomeController.index
	erb :index, locals: {notes: notes}
end

get '/note/:id' do |id|
	note = NoteController.find(id.to_i)
	
	return redirect to('/error404') if note.empty?
	
	erb :note_show, locals: {note: note}
end

get '/create_note' do
	erb :note_create
end

post '/store_note' do
	if NoteController.store(params)
		redirect to('/')
	else
		redirect to('/create_note')
	end
end

get '/edit_note/:id' do |id|
	note = NoteController.find(id.to_i)
	
	return redirect to('/error404') if note.empty?
	
	erb :note_edit, locals: {note: note}
end

post '/update_note/:id' do |id|
	if NoteController.update(params)
		redirect to('/')
	else
		redirect to("/edit_note/#{id}")
	end
end

post '/delete_note/:id' do |id|
	NoteController.delete(id.to_i)
	redirect to('/')
end

# routes (errors)

get '/error404' do
	"<h1>Página não encontrada!</h1><p>Para voltar clique <a href='/'>aqui</a></p>"
end
