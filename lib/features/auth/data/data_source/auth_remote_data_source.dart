import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/core/error/exceptions.dart';

// Abstract class for AuthRemoteDataSource
abstract class AuthRemoteDataSource {
  Future<void> registerUser({
    required String name,
    required String emailId,
    required String password,
    required DateTime createdAt,
  });

  Future<void> loginUser({
    required String emailId,
    required String password,
  });

  Future<void> passwordReset({required String emailId});

  Future<void> logoutUser();

  Future<void> deleteUser();
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
  Future<void> registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(email: emailId, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const APIException(message: "Weak Password", statusCode: 400);
      } else if (e.code == 'email-already-in-use') {
        throw const APIException(message: "Email already in use", statusCode: 409);
      } else {
        throw const APIException(message: "Something went wrong!", statusCode: 505);
      }
    }
  }

  @override
  Future<void> logoutUser() async {
    auth.signOut();
  }

  @override
  Future<void> passwordReset({required String emailId}) {
    try {
      return auth.sendPasswordResetEmail(email: emailId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const APIException(message: "User not found", statusCode: 404);
      } else {
        throw const APIException(message: "Something went wrong!", statusCode: 505);
      }
    }
  }

  @override
  Future<void> deleteUser() {
    try {
      return auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const APIException(message: "Requires recent login", statusCode: 401);
      } else {
        throw const APIException(message: "Something went wrong!", statusCode: 505);
      }
    }
  }
}
