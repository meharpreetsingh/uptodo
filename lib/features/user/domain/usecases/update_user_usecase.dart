import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';
import 'package:uptodo/features/user/domain/repository/user_repo.dart';

class UpdateUser extends UsecaseWithParams<UserData, UserData> {
  const UpdateUser(this._repo);
  final UserRepo _repo;

  @override
  ResultFuture<UserData> call(UserData params) => _repo.updateUserData(params);
}
