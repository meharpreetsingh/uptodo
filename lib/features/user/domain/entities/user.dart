import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.email,
    required this.name,
    required this.createdAt,
    this.gender,
    this.photoUrl,
    this.dob,
  });

  final String email;
  final String name;
  final DateTime createdAt;
  final String? gender;
  final String? photoUrl;
  final DateTime? dob;

  @override
  List<Object?> get props => [email];
}
