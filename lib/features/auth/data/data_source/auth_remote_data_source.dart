import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/core/error/exceptions.dart';

// Abstract class for AuthRemoteDataSource
abstract class AuthRemoteDataSource {
  Future<void> registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
  });

  Future<void> loginUser({
    required String emailId,
    required String password,
  });

  Future<void> logoutUser();
}

// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> loginUser({required String emailId, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailId, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const APIException(message: "User not found", statusCode: 404);
      } else if (e.code == 'wrong-password') {
        throw const APIException(message: 'Wrong Password', statusCode: 401);
      } else {
        throw const APIException(message: "Something went wrong!", statusCode: 505);
      }
    }
  }

  @override
  Future<void> registerUser({required DateTime createdAt, required String name, required String emailId}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }
}
