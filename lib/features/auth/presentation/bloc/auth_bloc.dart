import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/auth/domain/usecases/login_user.dart';
import 'package:uptodo/features/auth/domain/usecases/register_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.registerUser,
    required this.loginUser,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthLoginEvent>(_onAuthLogin);
  }

  final RegisterUser registerUser;
  final LoginUser loginUser;

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final String emailId = event.emailId;
    final String password = event.password;
    emit(AuthLoginLoading());
    final result = await loginUser(LoginUserParams(emailId: emailId, password: password));
    result.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthLoginSuccess()),
    );
  }
}
