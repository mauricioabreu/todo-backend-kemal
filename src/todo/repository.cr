require "json"

module Todo

  class TodoItem
    JSON.mapping({
      _id:  String,
      title: String,
      completed: Bool,
    })
  end

  class TodoRepository
    def initialize
      @todo_list = {} of String => TodoItem
    end

    def get_all
      list = Array(TodoItem).new
      @todo_list.each do |key, value|
        list.push(TodoItem.from_json value.to_json)
      end
      list
    end

    def get_todo(todo_id : String)
      TodoItem.from_json @todo_list[todo_id].to_json
    end

    def save(todo : TodoItem)
      @todo_list[todo._id] = todo
    end

    def delete(todo_id : String)
      @todo_list.delete todo_id
    end

    def clear
      @todo_list.clear
    end

  end

end
