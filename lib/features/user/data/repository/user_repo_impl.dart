import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:uptodo/features/user/data/models/user_model.dart';
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
      log("[getUserData] Error: ${e.message}");
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserData> updateUserData(UserData userData) async {
    try {
      final UserModel result = await _remoteDataSource.updateUser(UserModel.fromUserData(userData));
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserData> updatePhotoUrl(UserData userData, String photoUrl) async {
    try {
      final UserModel result = await _remoteDataSource.updatePhotoUrl(UserModel.fromUserData(userData), photoUrl);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
