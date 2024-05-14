import 'package:equatable/equatable.dart';

abstract class NetworkCallFailure extends Equatable {
  const NetworkCallFailure({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  List<Object> get props => [statusCode, message];
}
