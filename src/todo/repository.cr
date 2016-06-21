require "json"

module Todo
  class TodoList
    JSON.mapping({
      _id:       String,
      todo_list: Array(TodoItem),
    })
  end

  class TodoItem
    JSON.mapping({
      _id:  String,
      name: String,
      done: Bool,
    })
  end

  class TodoRepository
    def initialize
      @todo_list = {
        "default_todo" => TodoList.new "default_todo",
      }
    end

    def get_all
      list = Array(TodoList).new
      @todo_list.each do |key, value|
        list.push(TodoList.from_json value.to_json)
      end
      list
    end

    def get_todo(todo_id : String)
      TodoList.from_json @todo_list[todo_id].to_json
    end

    def save(todo : TodoList)
      @todo_list[todo._id] = todo
    end

    def delete(todo : TotoList)
    end
  end
end
