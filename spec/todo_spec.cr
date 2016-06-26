require "./spec_helper"

describe Todo do
  describe Todo::TodoHandler do
    describe "list_todos" do
      context "when a fresh instance" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        data = {"title" => "Buy milk"}
        handler.add_todo_item data
        todo_list = handler.list_todos
        it "should list all available todo lists" do
          todo_list.size.should eq 1
        end
      end
    end

    describe "add_todo_item" do
      it "should add a todo into repository" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        data = {"title" => "Finish work"}
        todo_item = handler.add_todo_item data
        todo_item.title.should eq "Finish work"
        todo_item.is_done.should be_false
        todo_item._id.should be_a(String)
      end
    end

    describe "get_todo_item" do
      it "should retrieve a todo item" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        data = {"title" => "Buy milk"}
        todo_item = handler.add_todo_item data
        todo_item = handler.get_todo_item todo_item._id
        todo_item.title.should eq "Buy milk"
      end
    end

    describe "remove_todo_item" do
      it "should remove existent todo items" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        data = {"title" => "Finish work"}
        todo_item = handler.add_todo_item data
        handler.remove_todo_item todo_item._id
        handler.list_todos.size.should eq 0
      end
    end

    describe "clear_todo" do
      it "should clear all todo items from a todo list" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        data = {"title" => "Finish work"}
        handler.add_todo_item data
        data = {"title" => "Read a book"}
        handler.add_todo_item data
        handler.list_todos.size.should eq 2
        handler.clear_todo
        handler.list_todos.size.should eq 0
      end
    end

    describe "update_todo_item" do
      it "should update todo attributes" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        data = {"title" => "Read a book"}
        todo_item = handler.add_todo_item data
        todo_item.title.should eq "Read a book"
        data = {"title" => "Buy a new book"}
        todo_item = handler.update_todo_item todo_item._id, data
        todo_item.title.should eq "Buy a new book"
        handler.list_todos.size.should eq 1
      end
    end
  end
end
