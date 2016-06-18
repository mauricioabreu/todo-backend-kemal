module Todo

  class TodoRepository

    def initialize
      @todo_list = {
        "default_todo" => TodoList.new "default_todo"
      }
    end

    def get_all
      list = Array(TodoList).new
      @todo_list.each do |i|
        list.push(@todo_list[i])
      end
      list
    end

    def get_todo(todo_id : String)
      @todo_list[todo_id]
    end

    def get_todo_item(todo_item_id : String)

    end

    def save(todo : TodoList)

    end

    def delete(todo : TotoList)

    end

  end

end
