import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';

class GoogleSignIn extends UsecaseWithoutParams<void> {
  const GoogleSignIn(this._repository);
  final AuthRepository _repository;

  @override
  ResultVoid call() async => _repository.googleSignIn();
}
