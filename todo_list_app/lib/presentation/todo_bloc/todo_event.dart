part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;

  const RemoveTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

// class AlterTodoEvent extends TodoEvent {
//   final int index;

//   const AlterTodoEvent(this.index);

//   @override
//   List<Object?> get props => [index];
// }

class AlterTodoEvent extends TodoEvent {
  final int index;
  final bool isDone;

  const AlterTodoEvent(this.index, this.isDone);

  @override
  List<Object> get props => [index, isDone];
}
