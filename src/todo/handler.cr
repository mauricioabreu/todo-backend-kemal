require "secure_random"

module Todo
  class TodoHandler
    def initialize(@todo_repo : TodoRepository)
    end

    def add_todo_item(item_title : String)
      todo_item = TodoItem.new item_title, SecureRandom.uuid
      @todo_repo.save(todo_item)
    end

    def remove_todo_item(item_id : String)
      @todo_repo.delete(item_id)
    end

    def list_todos
      @todo_repo.get_all
    end

    def clear_todo
      @todo_repo.clear
    end

    def get_todo(item_id : String)
      @todo_repo.get_todo item_id
    end

    def mark_as_done(item_id : String)
      item = @todo_repo.get_todo item_id
      # If don't have this if crystal throws a compile time error
      # because my find does not have a default value
      if item
        item.mark_as_done
      end
      @todo_repo.save(item)
    end
  end
end
