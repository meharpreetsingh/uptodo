import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/failure.dart';

/// Get Result with either `Failure` or `Type` as return type
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Get Result with either `Failure` or `void` as return type
typedef ResultVoid = ResultFuture<void>;

/// JSON data type
typedef DataMap = Map<String, dynamic>;
