import 'package:equatable/equatable.dart';
import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';

class RegisterUser extends UsecaseWithParams<void, RegisterUserParams> {
  const RegisterUser(this._repository);
  final AuthRepository _repository;

  @override
  ResultVoid call(RegisterUserParams params) async => _repository.registerUser(
        name: params.name,
        emailId: params.emailId,
        password: params.password,
        createdAt: params.createdAt,
      );
}

class RegisterUserParams extends Equatable {
  final DateTime createdAt;
  final String name;
  final String emailId;
  final String password;

  RegisterUserParams.empty()
      : this(
          name: "",
          emailId: "",
          password: "",
          createdAt: DateTime(2001, 02, 07),
        );

  const RegisterUserParams({
    required this.name,
    required this.emailId,
    required this.password,
    required this.createdAt,
  });

  @override
  List<Object> get props => [name, emailId];
}
