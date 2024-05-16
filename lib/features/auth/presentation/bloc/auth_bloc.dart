import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/auth/domain/usecases/login_user.dart';
import 'package:uptodo/features/auth/domain/usecases/logout_user.dart';
import 'package:uptodo/features/auth/domain/usecases/register_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.registerUser,
    required this.loginUser,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  final RegisterUser registerUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final String emailId = event.emailId;
    final String password = event.password;
    emit(AuthLoginLoading());
    final result = await loginUser(LoginUserParams(emailId: emailId, password: password));
    result.fold(
      (l) => emit(AuthLoginError(l.message)),
      (r) => emit(AuthLoginSuccess()),
    );
  }

  FutureOr<void> _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final String emailId = event.emailId;
    final String password = event.password;
    final String username = event.name;
    final DateTime createdAt = event.createdAt;
    emit(AuthRegisterLoading());
    final result = await registerUser(RegisterUserParams(
      emailId: emailId,
      password: password,
      name: username,
      createdAt: createdAt,
    ));
    result.fold(
      (l) => emit(AuthRegisterError(l.message)),
      (r) => emit(AuthRegisterSuccess()),
    );
  }

  FutureOr<void> _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    // emit(AuthLogoutLoading());
    final result = await logoutUser();
    result.fold(
      (l) => emit(AuthLogoutError(l.message)),
      (r) => emit(AuthInitial()),
    );
  }
}
