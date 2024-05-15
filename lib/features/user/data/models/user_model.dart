import 'package:uptodo/features/user/domain/entities/user.dart';

class UserModel extends UserData {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.createdAt,
    super.dob,
    super.gender,
    super.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt,
      'gender': gender,
      'photoUrl': photoUrl,
      'dob': dob,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      createdAt: map['createdAt'],
      gender: map['gender'],
      photoUrl: map['photoUrl'],
      dob: map['dob'],
    );
  }
}
