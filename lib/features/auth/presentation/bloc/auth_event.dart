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

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final DateTime createdAt;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
  });
}

class AuthLogoutEvent extends AuthEvent {}
