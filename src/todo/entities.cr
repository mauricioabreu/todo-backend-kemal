module Todo

  class TodoItem
    def initialize(@title : String, @_id : String, @order : Int32, @completed = false)
    end

    def order(order : Int32)
      @order = order
    end

    def order
      @order
    end

    def _id
      @_id
    end

    def title
      @title
    end

    def completed
      @completed
    end

    def mark_as_done
      @completed = true
    end
  end

end
