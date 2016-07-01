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
    "completed" => todo.completed,
    "url"   => base_url + todo_url(todo._id)
  }
end

before_all "/todos" do |env|
  # Support CORS and set responses to JSON as default.
  headers env, {
    "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/json",
    "Access-Control-Allow-Headers" => "Content-Type"
  }
end

before_all "/todos/:id" do |env|
  # Support CORS and set responses to JSON as default.
  headers env, {
    "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/json",
    "Access-Control-Allow-Headers" => "Content-Type"
  }
end

get "/" do |env|
  env.redirect TODOS_URI
end

options "/todos" do |env|
  headers env, {
    "Access-Control-Allow-Methods" => "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
  }
end

get "/todos" do |env|
  todos = Handler.list_todos
  todos.map { |todo| repr(todo, base_url(env)) }.to_json
end

options "/todos/:id" do |env|
  headers env, {
    "Access-Control-Allow-Methods" => "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
  }
end

get "/todos/:id" do |env|
  id = env.params.url["id"].as(String)
  todo = Handler.get_todo id
  repr(todo, base_url(env)).to_json
end

post "/todos" do |env|
  title = env.params.json["title"].as(String)
  order = env.params.json.fetch("order", nil) as (Nil | Int64)
  todo = Handler.add_todo_item title, order
  env.response.status_code = 201
  repr(todo, base_url(env)).to_json
end

patch "/todos/:id" do |env|
  id = env.params.url["id"].as(String)
  todo = Handler.get_todo id
  title = env.params.json.fetch("title", todo.title) as String
  completed = env.params.json.fetch("completed", todo.completed) as Bool
  order = env.params.json.fetch("order", todo.order) as (Int32 | Int64)
  todo = Handler.update_todo_item id, item_title: title, completed: completed, order: order
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
