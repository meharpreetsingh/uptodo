import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';
import 'package:uptodo/features/user/domain/usecases/get_user_usecase.dart';
import 'package:uptodo/features/user/domain/usecases/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required GetUser getUser, required UpdateUser updateUser})
      : _getUser = getUser,
        _updateUser = updateUser,
        super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  final GetUser _getUser;
  final UpdateUser _updateUser;

  Future<FutureOr<void>> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    log("[_onGetUser] 🌐 Getting user data...");
    final result = await _getUser();
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserFound(user)),
    );
    log("[_onGetUser] 🌐 User data found!");
  }

  FutureOr<void> _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) {}
}
