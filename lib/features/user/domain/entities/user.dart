import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    this.gender,
    this.photoUrl,
    this.dob,
  });

  final String id;
  final String email;
  final String name;
  final String createdAt;
  final String? gender;
  final String? photoUrl;
  final DateTime? dob;

  @override
  List<Object?> get props => [id, email];

  UserData copyWith({
    String? id,
    String? email,
    String? name,
    String? createdAt,
    String? gender,
    String? photoUrl,
    DateTime? dob,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      gender: gender ?? this.gender,
      photoUrl: photoUrl ?? this.photoUrl,
      dob: dob ?? this.dob,
    );
  }
}
