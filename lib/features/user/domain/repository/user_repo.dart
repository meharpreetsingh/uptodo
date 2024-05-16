import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';

abstract class UserRepo {
  const UserRepo();

  ResultFuture<UserData> getUserData();
  ResultFuture<UserData> updateUserData(UserData userData);
  ResultFuture<UserData> updatePhotoUrl(UserData userData, String photoUrl);
}
