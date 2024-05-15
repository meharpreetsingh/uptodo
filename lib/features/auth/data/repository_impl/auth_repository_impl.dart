import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultVoid deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  ResultVoid loginUser({required String emailId, required String password}) async {
    try {
      await _remoteDataSource.loginUser(emailId: emailId, password: password);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  ResultVoid registerUser({required DateTime createdAt, required String name, required String emailId}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  ResultVoid updatePassword({required String uid, required String password}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}