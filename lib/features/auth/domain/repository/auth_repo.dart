import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/auth/domain/entity/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
  });

  ResultFuture<UserAuth> loginUser({
    required String emailId,
    required String password,
  });

  ResultFuture<UserAuth> updatePassword({
    required String uid,
    required String password,
  });

  ResultVoid logoutUser();
  ResultVoid deleteUser();
}
