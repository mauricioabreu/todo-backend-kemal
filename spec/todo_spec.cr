require "./spec_helper"

describe Todo do
  describe Todo::TodoHandler do

    describe "add_todo" do
      it "should add a todo into repository" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "Finish work"
        all_items = handler.list_todos
        all_items.size.should eq 1
        all_items.[0].title.should eq "Finish work"
        all_items.[0].completed.should be_false
        all_items.[0].order.should eq 1
        all_items.[0]._id.should be_a(String)
      end

      it "should accept order parameter" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "Finish work", 500
        item = handler.list_todos[0]
        item.order.should eq 500
      end
    end

    describe "remove_todo_item" do
      it "should remove existent todo items" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "Finish work"
        all_items = handler.list_todos
        handler.remove_todo_item all_items[0]._id
        all_items = handler.list_todos
        all_items.size.should eq 0
      end
    end

    describe "list_todos" do
      it "should list all todo items from a todo list" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "Finish work"
        items = handler.list_todos
        items.size.should eq 1
      end
    end

    describe "clear_todo" do
      it "should clear all todo items from a todo list" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "Finish work"
        items = handler.list_todos
        items.size.should eq 1
        handler.clear_todo
        items = handler.list_todos
        items.size.should eq 0
      end
    end

    describe "update_todo" do
      it "Should mark a single todo as marked" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        item = handler.add_todo_item "Finish work"
        handler.update_todo_item item._id, completed: true, item_title: "Another title", order: 1 
        items = handler.get_todo item._id
        items.completed.should be_true
      end

    end
  end
end
