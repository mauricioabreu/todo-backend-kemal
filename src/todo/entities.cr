module Todo
  class TodoList
    def initialize(@_id : String)
      @todo_list = Array(TodoItem).new
    end

    def _id
      @_id
    end

    def todo_list
      @todo_list
    end

    def add_item(item : TodoItem)
      @todo_list.push(item)
    end

    def remove_item(item_id : String)
      @todo_list = @todo_list.reject { |i| i._id == item_id }
    end

    def clear
      @todo_list = Array(TodoItem).new
    end

    def get_item(item_id : String)
      @todo_list.find do |item|
        item._id == item_id
      end
    end
  end

  class TodoItem
    def initialize(@name : String, @_id : String, @done = false)
    end

    def _id
      @_id
    end

    def name
      @name
    end

    def is_done
      @done
    end

    def mark_as_done
      @done = true
    end
  end
end
