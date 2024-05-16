import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';

class UserModel extends UserData {
  const UserModel({
    required super.uid,
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
      uid: doc.id,
      email: data['email'] as String,
      name: data['name'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      dob: (data['dob'] as Timestamp?)?.toDate(),
      gender: data['gender'] as String?,
      photoUrl: data['photoUrl'] as String?,
    );
  }

  DataMap toMap() {
    return {
      "email": email,
      "name": name,
      "createdAt": createdAt,
      "dob": dob,
      "gender": gender,
      "photoUrl": photoUrl,
    };
  }

  static fromUserData(UserData data) {
    return UserModel(
      uid: data.uid,
      email: data.email,
      name: data.name,
      createdAt: data.createdAt,
      dob: data.dob,
      gender: data.gender,
      photoUrl: data.photoUrl,
    );
  }

  @override
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    DateTime? createdAt,
    String? gender,
    String? photoUrl,
    DateTime? dob,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        gender: gender ?? this.gender,
        photoUrl: photoUrl ?? this.photoUrl,
        dob: dob ?? this.dob,
      );
}
