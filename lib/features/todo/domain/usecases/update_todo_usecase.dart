import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/domain/repository/todo_repo.dart';

class UpdateTodo extends UsecaseWithParams<Todo, Todo> {
  UpdateTodo(this._repo);
  final TodoRepo _repo;

  @override
  ResultFuture<Todo> call(Todo params) => _repo.updateTodo(params);
}
