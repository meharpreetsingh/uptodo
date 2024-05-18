part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class GetTodosEvent extends TodoEvent {
  final String uid;
  GetTodosEvent(this.uid);
}

final class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  UpdateTodoEvent(this.todo);
}

final class CreateTodoEvent extends TodoEvent {
  final Todo todo;
  CreateTodoEvent(this.todo);
}
