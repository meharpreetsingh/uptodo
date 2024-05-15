import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<String> registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
  });

  Future<String> loginUser({
    required String emailId,
    required String password,
  });

  Future<void> logoutUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  const AuthRemoteDataSourceImpl(this.auth);

  @override
  Future<String> loginUser({required String emailId, required String password}) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<String> registerUser({required DateTime createdAt, required String name, required String emailId}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }
}
