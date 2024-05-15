part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthRegisterLoading extends AuthState {}

final class AuthRegisterSuccess extends AuthState {}

final class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
}
