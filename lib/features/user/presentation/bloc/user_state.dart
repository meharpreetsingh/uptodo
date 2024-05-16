part of 'user_bloc.dart';

@immutable
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  final String message;
  const UserError(this.message);
}

final class UserFound extends UserState {
  final UserData user;
  const UserFound(this.user);
}

final class UpdatingUser extends UserFound {
  const UpdatingUser(UserData user) : super(user);
}
