import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/features/todo/data/data_source/todo_remote_data_source.dart';
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
}
