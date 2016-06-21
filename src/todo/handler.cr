require "secure_random"

module Todo
  class TodoHandler
    def initialize(@todo_repo : TodoRepository)
    end

    def add_todo_item(todo_id : String, item_name : String)
      todo = @todo_repo.get_todo todo_id
      todo_item = TodoItem.new item_name, SecureRandom.uuid
      todo.add_item todo_item
      @todo_repo.save(todo)
    end

    def remove_todo_item(todo_id : String, item_id : String)
      todo = @todo_repo.get_todo todo_id
      todo.remove_item item_id
      @todo_repo.save(todo)
    end

    def list_todos
      @todo_repo.get_all
    end

    def list_todo_items(todo_id : String)
      todo = @todo_repo.get_todo todo_id
      todo.todo_list
    end

    def clear_todo(todo_id : String)
      todo = @todo_repo.get_todo todo_id
      todo.clear
      @todo_repo.save(todo)
    end

    def mark_as_done(todo_id : String, item_id : String)
      todo = @todo_repo.get_todo todo_id
      item = todo.get_item item_id
      # If don't have this if crystal throws a compile time error
      # because my find does not have a default value
      if item
        item.mark_as_done
      end
      @todo_repo.save(todo)
    end
  end
end
