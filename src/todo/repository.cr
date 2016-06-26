require "json"

module Todo
  class TodoRepository
    def initialize
      @todo_list = {} of String => Hash(String, String)
    end

    def get_all
      @todo_list.values
    end

    def get_todo(todo_id : String)
      @todo_list[todo_id]
    end

    def save(todo)
      @todo_list[todo["_id"]] = todo
    end

    def delete(todo_id : String)
      @todo_list.delete(todo_id)
    end

    def clear
      @todo_list.clear
    end
  end
end
