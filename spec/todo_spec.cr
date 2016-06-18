require "./spec_helper"
require "spec2"

Spec2.describe Todo do

  describe Todo::TodoHandler do
    describe "list_todos" do
      context "When a fresh instance" do
        let(handler) { Todo::TodoHandler.new Todo::TodoRepository.new }
        let(todos) { handler.list_todos }
        it "should list all available todo lists" do
          expect(todos.size).to eq 1
        end
      end
    end

    describe "add_todo" do
      it "should add a todo into repository" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "default_todo", "Finish work"
        default_todo = handler.list_todos[0]
        expect(default_todo.todo_list.size).to eq 1
        expect(default_todo.todo_list[0].name).to eq "Finish work"
        expect(default_todo.todo_list[0].is_done).to be_false
        expect(default_todo.todo_list[0]._id.is_a?(String)).to be_true
      end
    end

    describe "remove_todo_item" do
      it "should remove existent todo items" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "default_todo", "Finish work"
        default_todo = handler.list_todos[0]
        todo_item = default_todo.todo_list[0]
        handler.remove_todo_item default_todo._id, todo_item._id
        default_todo = handler.list_todos[0]
        expect(default_todo.todo_list.size).to eq 0
      end
    end

    describe "list_todo_items" do
      it "should list all todo items from a todo list" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "default_todo", "Finish work"
        items = handler.list_todo_items "default_todo"
        expect(items.size).to eq 1
      end
    end

    describe "clear_todo" do
      it "should clear all todo items from a todo list" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "default_todo", "Finish work"
        handler.clear_todo "default_todo"
        items = handler.list_todo_items "default_todo"
        expect(items.size).to eq 0
      end
    end

    describe "mark_as_done" do
      it "Should mark a single todo as marked" do
        handler = Todo::TodoHandler.new Todo::TodoRepository.new
        handler.add_todo_item "default_todo", "Finish work"
        items = handler.list_todo_items "default_todo"
        item = items[0]
        handler.mark_as_done "default_todo", item._id
        items = handler.list_todo_items "default_todo"
        expect(items[0].is_done).to be_true
      end
    end

  end

end
