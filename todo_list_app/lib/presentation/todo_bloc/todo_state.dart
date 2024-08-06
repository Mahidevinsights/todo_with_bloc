part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

enum TodoFilter { all, completed, pending }

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;
  final TodoFilter filter;

  const TodoState({
    this.todos = const [],
    this.status = TodoStatus.initial,
    this.filter = TodoFilter.all,
  });

  @override
  List<Object> get props => [todos, status, filter];

  TodoState copyWith({
    List<Todo>? todos,
    TodoStatus? status,
    TodoFilter? filter,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      filter: filter ?? this.filter,
    );
  }

  static TodoState fromJson(Map<String, dynamic> json) {
    return TodoState(
      todos: List<Todo>.from(json['todos'].map((x) => Todo.fromJson(x))),
      status: TodoStatus.values[json['status']],
      filter: TodoFilter.values[json['filter']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((x) => x.toJson()).toList(),
      'status': status.index,
      'filter': filter.index,
    };
  }
}
