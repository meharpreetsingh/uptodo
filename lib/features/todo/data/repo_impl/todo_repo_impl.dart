import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/todo/data/data_source/todo_remote_data_source.dart';
import 'package:uptodo/features/todo/data/models/todo_model.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/domain/repository/todo_repo.dart';

class TodoRepoImpl extends TodoRepo {
  TodoRepoImpl(this._todoRemoteDataSource);
  final TodoRemoteDataSource _todoRemoteDataSource;

  @override
  Either<Failure, Stream<List<Todo>>> getTodos(String uid) {
    try {
      return Right(_todoRemoteDataSource.getTodos(uid));
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Todo> getTodoById(String id) {
    // TODO: implement getTodoById
    throw UnimplementedError();
  }

  @override
  ResultFuture<Todo> updateTodo(Todo todo) async {
    try {
      final result = await _todoRemoteDataSource.updateTodo(TodoModel.fromTodo(todo));
      return Right(result);
    } on APIException catch (e) {
      return ResultFuture.error(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Todo> createTodo(Todo todo) async {
    try {
      final result = await _todoRemoteDataSource.createTodo(TodoModel.fromTodo(todo));
      return Right(result);
    } on APIException catch (e) {
      return ResultFuture.error(APIFailure.fromException(e));
    }
  }
}
