import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';

abstract class TodoRepo {
  Either<Failure, Stream<List<Todo>>> getTodos(String uid);
  ResultFuture<Todo> getTodoById(String id);
  ResultFuture<Todo> updateTodo(Todo todo);
  ResultFuture<Todo> createTodo(Todo todo);
}
