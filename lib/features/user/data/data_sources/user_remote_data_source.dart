import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
  Future<UserModel> updateUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
