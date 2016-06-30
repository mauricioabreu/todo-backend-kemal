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

    def update_todo_item(item_id : String, *, item_title : String,
                         completed : Bool, order : Int64)
      update_todo_item item_id, item_title: item_title, completed: completed, order: order.to_i
    end

    def update_todo_item(item_id : String, *, item_title : String,
                         completed : Bool, order : Int32)
      todo = @todo_repo.get_todo item_id
      todo.title = item_title
      todo.completed = completed
      todo.order = order.as Int32
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
