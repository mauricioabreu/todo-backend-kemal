require "secure_random"

module Todo
  class TodoHandler
    def initialize(@todo_repo : TodoRepository)
    end

    def add_todo_item(item_title : String, order : Int32 = nil)
      if order == nil
        order = @todo_repo.size + 1
      end
      todo_item = TodoItem.new item_title, SecureRandom.uuid, order.as Int32
      @todo_repo.save todo_item
    end

    def update_todo_item(item_id : String, *, item_title : String = nil, completed : Bool = nil)
      todo = @todo_repo.get_todo item_id
      todo.title = !item_title.nil? ? item_title.as String : todo.title
      todo.completed = !completed.nil? ? completed.as Bool : todo.completed
      @todo_repo.save todo
    end

    def remove_todo_item(item_id : String)
      @todo_repo.delete item_id
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

  end
end
