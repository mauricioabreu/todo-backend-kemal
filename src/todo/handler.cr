require "secure_random"


module Todo
  class TodoHandler
    def initialize(@todo_repo : TodoRepository)
    end

    def add_todo_item(todo_item)
      todo_item["_id"] = SecureRandom.uuid
      TodoItem.from_json(@todo_repo.save(todo_item).to_json)
    end

    def update_todo_item(item_id, todo_item)
      todo_item["_id"] = item_id
      TodoItem.from_json(@todo_repo.save(todo_item).to_json)
    end

    def get_todo_item(item_id)
      TodoItem.from_json(@todo_repo.get_todo(item_id).to_json)
    end

    def remove_todo_item(item_id)
      @todo_repo.delete item_id
    end

    def list_todos
      todos = [] of TodoItem
      @todo_repo.get_all.each do |todo|
        todos.push(TodoItem.from_json todo.to_json)
      end
      todos
    end

    def clear_todo
      @todo_repo.clear
    end
  end
end
