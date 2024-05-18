import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';
import 'package:uptodo/features/user/domain/usecases/get_user_usecase.dart';
import 'package:uptodo/features/user/domain/usecases/update_photo_url.dart';
import 'package:uptodo/features/user/domain/usecases/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required GetUser getUser, required UpdateUser updateUser, required UpdatePhotoUrl updatePhotoUrl})
      : _getUser = getUser,
        _updateUser = updateUser,
        _updatePhotoUrl = updatePhotoUrl,
        super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<UpdatePhotoUrlEvent>(_onUpdatePhotoUrl);
  }

  final GetUser _getUser;
  final UpdateUser _updateUser;
  final UpdatePhotoUrl _updatePhotoUrl;

  FutureOr<void> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await _getUser();
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserFound(user)),
    );
  }

  FutureOr<void> _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UpdatingUser(event.user));
    final result = await _updateUser(event.user);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserFound(user)),
    );
  }

  FutureOr<void> _onUpdatePhotoUrl(UpdatePhotoUrlEvent event, Emitter<UserState> emit) async {
    emit(UpdatingUser(event.user));
    // TODO: Check why the new image is not being displayed
    final result = await _updatePhotoUrl(UpdatePhotoUrlParams(event.user, event.photoUrl));
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) {
        emit(UserFound(user));
      },
    );
  }
}
