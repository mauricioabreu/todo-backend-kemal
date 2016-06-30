require "./todo"
require "kemal"

# Base resource path.
TODOS_URI = "/todos"

Handler = Todo::TodoHandler.new Todo::TodoRepository.new

def base_url(env)
  # Set base url like this because Kemal does not
  # support URI parse like Sinatra does.
  # See: https://github.com/sdogruyol/kemal/issues/148
  "http://" + env.request.headers["host"]
end

def todo_url(id)
  "#{TODOS_URI}/#{id}"
end

def repr(todo, base_url)
  {"uid"   => todo._id,
    "title" => todo.title,
    "order" => todo.order,
    "url"   => base_url + todo_url(todo._id)
  }
end

before_all "/todos" do |env|
  # Support CORS and set responses to JSON as default.
  headers env, {
    "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/json"
  }
end


get "/" do |env|
  env.redirect TODOS_URI
end

get "/todos" do |env|
  todos = Handler.list_todos
  todos.map { |todo| repr(todo, base_url(env)) }.to_json
end

get "/todos/:id" do |env|
  id = env.params.url["id"].as(String)
  todo = Handler.get_todo id
  repr(todo, base_url(env)).to_json
end

post "/todos" do |env|
  title = env.params.json["title"].as(String)
  todo = Handler.add_todo_item title
  env.response.status_code = 201
  repr(todo, base_url(env)).to_json
end

delete "/todos" do |env|
  Handler.clear_todo
  env.response.status_code = 204
end

delete "/todos/:id" do |env|
  id = env.params.url["id"].as(String)
  Handler.remove_todo_item id
  env.response.status_code = 204
end

Kemal.run
