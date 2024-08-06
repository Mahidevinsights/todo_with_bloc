part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;

  const RemoveTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class AlterTodoEvent extends TodoEvent {
  final int index;
  final bool isDone;

  const AlterTodoEvent(this.index, this.isDone);

  @override
  List<Object> get props => [index, isDone];
}

class ChangeFilterEvent extends TodoEvent {
  final TodoFilter filter;

  const ChangeFilterEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
