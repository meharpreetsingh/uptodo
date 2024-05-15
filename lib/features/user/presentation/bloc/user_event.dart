part of 'user_bloc.dart';

@immutable
sealed class UserEvent {
  const UserEvent();
}

final class GetUserEvent extends UserEvent {}

final class UpdateUserEvent extends UserEvent {
  final UserData user;
  const UpdateUserEvent(this.user);
}
