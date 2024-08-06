import 'package:todo_list_app/data/models/todo.dart';
import '../../data/repositories/todo_repository.dart';

//used for adding to-do
class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  void call(Todo todo) {
    repository.addTodo(todo);
  }
}

//used for remove to-do
class RemoveTodo {
  final TodoRepository repository;

  RemoveTodo(this.repository);

  void call(Todo todo) {
    repository.removeTodo(todo);
  }
}

//used for get to-do
class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  List<Todo> call() {
    return repository.todos;
  }
}

//used for filltering to-do
class AlterTodo {
  final TodoRepository repository;

  AlterTodo(this.repository);

  void call(int index, bool isDone) {
    repository.updateTodoStatus(index, isDone);
  }
}
