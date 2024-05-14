import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
