import 'package:uptodo/core/util/typedef.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
  });

  ResultVoid loginUser({
    required String emailId,
    required String password,
  });

  ResultVoid updatePassword({
    required String uid,
    required String password,
  });

  ResultVoid logoutUser();
  ResultVoid deleteUser();
}
