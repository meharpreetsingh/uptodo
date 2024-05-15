import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:uptodo/features/user/domain/entities/user.dart';
import 'package:uptodo/features/user/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  UserRepoImpl(this._remoteDataSource);
  final UserRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<UserData> getUserData() async {
    try {
      final result = await _remoteDataSource.getUser();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserData> updateUserData(UserData userData) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
