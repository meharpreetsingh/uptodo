part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String emailId;
  final String password;

  const AuthLoginEvent({
    required this.emailId,
    required this.password,
  });
}

class AuthGoogleSignInEvent extends AuthEvent {}

class AuthGoogleSignUpEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String name;
  final String emailId;
  final String password;
  final DateTime createdAt;

  const AuthRegisterEvent({
    required this.name,
    required this.emailId,
    required this.password,
    required this.createdAt,
  });
}

class AuthLogoutEvent extends AuthEvent {}
