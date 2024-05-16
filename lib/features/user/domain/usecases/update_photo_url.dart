import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';
import 'package:uptodo/features/user/domain/repository/user_repo.dart';

class UpdatePhotoUrl extends UsecaseWithParams<UserData, UpdatePhotoUrlParams> {
  const UpdatePhotoUrl(this._repo);
  final UserRepo _repo;

  @override
  ResultFuture<UserData> call(UpdatePhotoUrlParams params) => _repo.updatePhotoUrl(params.userData, params.photoUrl);
}

class UpdatePhotoUrlParams {
  final UserData userData;
  final String photoUrl;

  const UpdatePhotoUrlParams(this.userData, this.photoUrl);
}
