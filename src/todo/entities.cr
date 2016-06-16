module Todo

  class TodoList

    def initialize
      @todo_list = Array(TodoItem).new
    end

    def todo_list
      @todo_list
    end

    def add_item(item: TodoItem)
      @todo_list.push(item)
    end

    def remove_item(item: TodoItem)
      @todo_list.delete(item)
    end

  end


  class TodoItem

    def initialize(@name: String, @checked = false)
    end

    def mark_as_done
      @checked = true
    end

  end


end
