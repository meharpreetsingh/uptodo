import 'package:equatable/equatable.dart';

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

class ApiFailure extends Failure {
  const ApiFailure({required super.statusCode, required super.message});
}
