import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/domain/repository/todo_repo.dart';

class GetTodos {
  final TodoRepo _todoRepo;
  GetTodos(this._todoRepo);

  Either<Failure, Stream<List<Todo>>> call(GetTodosParams params) => _todoRepo.getTodos(params.uid);
}

class GetTodosParams {
  final String uid;
  GetTodosParams(this.uid);
}
