import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/domain/repository/todo_repo.dart';

class CreateTodo extends UsecaseWithParams<Todo, Todo> {
  CreateTodo(this._todoRepo);
  final TodoRepo _todoRepo;

  @override
  ResultFuture<Todo> call(params) => _todoRepo.createTodo(params);
}
