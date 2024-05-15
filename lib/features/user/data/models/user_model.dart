import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';

class UserModel extends UserData {
  const UserModel({
    required super.email,
    required super.name,
    required super.createdAt,
    super.dob,
    super.gender,
    super.photoUrl,
  });

  factory UserModel.fromFirestoreDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      email: data['email'] as String,
      name: data['name'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      dob: (data['dob'] as Timestamp?)?.toDate(),
      gender: data['gender'] as String?,
      photoUrl: data['photoUrl'] as String?,
    );
  }
}
