module Todo

  class TodoItem
    def initialize(@title : String, @_id : String, @completed= false)
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
