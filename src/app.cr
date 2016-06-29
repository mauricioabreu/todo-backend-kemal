require "./todo"
require "kemal"


TODOS_URI = "/todos"

Handler = Todo::TodoHandler.new Todo::TodoRepository.new


get "/" do |env|
  env.redirect TODOS_URI
end

get "/todos" do
  todos = Handler.list_todos
  todos.to_json
end

post "/todos" do |env|
  title = env.params.json["title"] as String
  todo = Handler.add_todo_item title
  env.response.status_code = 201
  todo.to_json
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
