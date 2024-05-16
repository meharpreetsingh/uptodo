import 'package:equatable/equatable.dart';
import 'package:uptodo/core/error/exceptions.dart';

// abstract class Failure extends Equatable {
//   final List<dynamic> properties;
//   const Failure({this.properties = const <dynamic>[]}) : super();
//
//   @override
//   List<Object> get props => [properties];
// }

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  List<Object> get props => [statusCode, message];
}

class APIFailure extends Failure {
  const APIFailure({required super.statusCode, required super.message});
  APIFailure.fromException(APIException exception) : super(message: exception.message, statusCode: exception.statusCode);
}

class LocalDataFailure extends Failure {
  const LocalDataFailure({required super.statusCode, required super.message});
  LocalDataFailure.fromException(LocalDataException exception)
      : super(message: exception.message, statusCode: exception.statusCode);
}
