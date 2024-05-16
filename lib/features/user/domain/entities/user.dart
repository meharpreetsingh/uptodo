import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    this.gender,
    this.photoUrl,
    this.dob,
  });

  final String uid;
  final String email;
  final String name;
  final DateTime createdAt;
  final String? gender;
  final String? photoUrl;
  final DateTime? dob;

  @override
  List<Object?> get props => [email];

  UserData copyWith({
    String? uid,
    String? email,
    String? name,
    DateTime? createdAt,
    String? gender,
    String? photoUrl,
    DateTime? dob,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      gender: gender ?? this.gender,
      photoUrl: photoUrl ?? this.photoUrl,
      dob: dob ?? this.dob,
    );
  }
}
