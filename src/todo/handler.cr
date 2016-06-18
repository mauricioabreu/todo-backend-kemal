module Todo

  class TodoHandler

    def initialize(@todo_repo: TodoRepository)
    end

    def add_todo_item(todo_id: String, item_name: String)

    end

    def remoe_todo_item(todo_id: String, item_id: String)

    end

    def list_todos(todo_id: String)

    end

    def clear_todo(todo_id: String)

    end

    def mark_as_done(todo_id: String, item_id: String)

    end

  end

end
