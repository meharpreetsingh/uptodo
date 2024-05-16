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

final class UpdatePhotoUrlEvent extends UserEvent {
  final UserData user;
  final String photoUrl;
  const UpdatePhotoUrlEvent(this.user, this.photoUrl);
}
