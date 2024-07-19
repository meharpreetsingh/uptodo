part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthRegisterLoading extends AuthState {}

final class AuthGoogleSignInLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthRegisterSuccess extends AuthState {}

final class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
}

final class AuthLoginError extends AuthError {
  const AuthLoginError(String message) : super(message);
}

final class AuthGoogleSignInError extends AuthError {
  const AuthGoogleSignInError(String message) : super(message);
}

final class AuthGoogleSignUpError extends AuthError {
  const AuthGoogleSignUpError(String message) : super(message);
}

final class AuthLogoutError extends AuthState {
  const AuthLogoutError(this.message);
  final String message;
}

final class AuthRegisterError extends AuthState {
  const AuthRegisterError(this.message);
  final String message;
}
