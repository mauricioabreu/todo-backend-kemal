require "./todo"
require "kemal"


TODOS_URI = "/todos"

Handler = Todo::TodoHandler.new Todo::TodoRepository.new

def base_url(env)
	env.request.scheme + "://" + env.request.host
end

def repr(todo)
	{"uid"   => todo._id,
	 "title" => todo.title,
	 "order" => todo.order,
	 "url"	 => "#{TODOS_URI}/#{todo._id}"}
end

get "/" do |env|
  env.redirect TODOS_URI
end

get "/todos" do
  todos = Handler.list_todos
	todos.map{ |todo| repr(todo)}.to_json
end

get "/todos/:id" do |env|
	id = env.params.url["id"] as String
	todo = Handler.get_todo id
	repr(todo).to_json
end

post "/todos" do |env|
  title = env.params.json["title"] as String
  todo = Handler.add_todo_item title
  env.response.status_code = 201
	repr(todo).to_json
end

delete "/todos" do |env|
  Handler.clear_todo
  env.response.status_code = 204
end

delete "/todos/:id" do |env|
  id = env.params.url["id"] as String
  Handler.remove_todo_item id
  env.response.status_code = 204
end

Kemal.run
