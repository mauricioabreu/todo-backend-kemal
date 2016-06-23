require "json"

module Todo
  class TodoItem
    JSON.mapping({
      _id: {type: String, nillable: true},
      title: String,
      completed: {type: Bool, nillable: true, default: false}
    })

    def initialize(@_id : String, @title : String, @completed : Bool)
    end

    def _id
      @_id
    end

    def is_done
      @completed
    end
  end
end
