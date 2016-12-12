require "./spec_helper"

describe Todo do
  it "shows empty list of todo items" do
    get "/todos"
    response.body.should eq "[]"
  end

  it "creates a new todo item" do
    json_body = {"title": "Buy milk"}
    post("/todos", headers: HTTP::Headers{"Content-Type" => "application/json", "Host" => "www.todo.com"}, body: json_body.to_json)
  end
end
