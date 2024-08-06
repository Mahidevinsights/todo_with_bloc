import '../models/todo.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
  }

  void updateTodoStatus(int index, bool isDone) {
    _todos[index] = _todos[index].copyWith(isDone: isDone);
  }
}
