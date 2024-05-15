import 'package:uptodo/core/util/typedef.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid registerUser({
    required String name,
    required String emailId,
    required String password,
    required DateTime createdAt,
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
