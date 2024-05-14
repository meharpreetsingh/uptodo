import 'package:equatable/equatable.dart';
import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';

class RegisterUser extends UsecaseWithParams<void, RegisterUserParams> {
  const RegisterUser(this._repository);
  final AuthRepository _repository;

  @override
  ResultFuture call(RegisterUserParams params) async => _repository.registerUser(
        createdAt: params.createdAt,
        name: params.name,
        emailId: params.emailId,
      );
}

class RegisterUserParams extends Equatable {
  final DateTime createdAt;
  final String name;
  final String emailId;

  RegisterUserParams.empty()
      : this(
          createdAt: DateTime(2001, 02, 07),
          name: "",
          emailId: "",
        );

  const RegisterUserParams({
    required this.createdAt,
    required this.name,
    required this.emailId,
  });

  @override
  List<Object> get props => [name, emailId];
}
