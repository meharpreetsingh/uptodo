import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
  Future<UserModel> updateUser(UserModel user);
  Future<UserModel> updatePhotoUrl(UserModel user, String photoUrl);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<UserModel> getUser() async {
    if (auth.currentUser == null) {
      throw const APIException(message: "User not logged in", statusCode: 404);
    }
    try {
      final String uid = auth.currentUser!.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore.collection("users").doc(uid).get();
      if (!userDoc.exists) throw const APIException(message: "User not found", statusCode: 404);
      return UserModel.fromFirestoreDoc(userDoc);
    } catch (e) {
      log("[getUser] ${e.toString()}");
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    if (auth.currentUser == null) throw const APIException(message: "User not logged in", statusCode: 404);
    try {
      final String uid = auth.currentUser!.uid;
      final DocumentReference<Map<String, dynamic>> userDoc = firestore.collection("users").doc(uid);
      await userDoc.set(user.toMap(), SetOptions(merge: true));
      return user;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<UserModel> updatePhotoUrl(UserModel user, String imagePath) async {
    try {
      final Reference ref = storage.ref().child("profile_images").child(user.uid);
      await ref.putFile(File(imagePath));
      final String photoUrl = await ref.getDownloadURL();
      final DocumentReference<Map<String, dynamic>> userDoc = firestore.collection("users").doc(user.uid);
      await userDoc.set(user.copyWith(photoUrl: photoUrl).toMap(), SetOptions(merge: true));
      return await getUser();
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
