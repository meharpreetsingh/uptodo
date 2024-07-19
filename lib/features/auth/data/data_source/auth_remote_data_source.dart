import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<void> signInWithGoogle();

  Future<void> passwordReset({required String emailId});
  Future<void> logoutUser();
  Future<void> deleteUser();
}

// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  @override
  Future<void> loginUser({required String emailId, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailId, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const APIException(message: "No user found for that email.", statusCode: 404);
      } else if (e.code == 'wrong-password') {
        throw const APIException(message: 'Wrong password provided for that user.', statusCode: 401);
      } else if (e.code == 'invalid-credential') {
        throw const APIException(message: 'Credentials are incorrect, malformed or has expired.', statusCode: 401);
      } else {
        throw const APIException(message: "Something went wrong!", statusCode: 505);
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw const APIException(message: "No user selected in Google SignIn", statusCode: 404);
      }
      String? uid = await _checkUserExists(googleUser.email);
      if (uid == null) {
        final response = await auth.createUserWithEmailAndPassword(
          email: googleUser.email,
          password: "\$google\$1234\$",
        );
        uid = response.user!.uid;
        await _createUserDetails(
          uid: uid,
          name: googleUser.displayName ?? "User",
          emailId: googleUser.email,
          createdAt: DateTime.now(),
          photoUrl: googleUser.photoUrl,
        );
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);
    } catch (e) {
      if (e is APIException) rethrow;
      log("[signInWithGoogle] $e");
      throw const APIException(message: "Something went wrong!", statusCode: 505);
    }
  }

  @override
  Future<void> registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
    required String password,
    String? photoUrl,
  }) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(email: emailId, password: password);
      await _createUserDetails(
          uid: response.user!.uid, name: name, emailId: emailId, createdAt: createdAt, photoUrl: photoUrl);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const APIException(message: "Weak Password", statusCode: 400);
      } else if (e.code == 'email-already-in-use') {
        throw const APIException(message: "Email already in use", statusCode: 409);
      } else {
        throw const APIException(message: "Something went wrong!", statusCode: 505);
      }
    } on APIException {
      rethrow;
    }
  }

  Future<void> _createUserDetails({
    required String uid,
    required String name,
    required String emailId,
    required DateTime createdAt,
    String? photoUrl,
  }) async {
    try {
      await firestore.collection('users').doc(uid).set({
        'name': name,
        'email': emailId,
        'createdAt': createdAt,
        'photoUrl': photoUrl,
      });
    } catch (e) {
      throw const APIException(message: "Failed to store user details!", statusCode: 505);
    }
  }

  Future<String?> _checkUserExists(String emailId) async {
    try {
      final response = await firestore.collection('users').where('email', isEqualTo: emailId).get();
      if (response.docs.isNotEmpty) return response.docs.first.id;
      return null;
    } catch (e) {
      throw const APIException(message: "Failed to check user exists!", statusCode: 505);
    }
  }

  @override
  Future<void> logoutUser() async {
    await GoogleSignIn().signOut();
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
