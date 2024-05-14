import 'package:equatable/equatable.dart';
import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';

class LoginUser extends UsecaseWithParams<void, LoginUserParams> {
  const LoginUser(this._repository);
  final AuthRepository _repository;

  @override
  ResultFuture call(LoginUserParams params) async => _repository.loginUser(
        emailId: params.emailId,
        password: params.password,
      );
}

class LoginUserParams extends Equatable {
  final String emailId;
  final String password;

  const LoginUserParams({
    required this.emailId,
    required this.password,
  });

  @override
  List<Object> get props => [emailId, password];
}
