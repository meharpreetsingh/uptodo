import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/theme/domain/entity/app_theme_mode.dart';
import 'package:uptodo/features/theme/domain/repository/theme_repo.dart';

class GetThemeMode extends UsecaseWithoutParams<AppThemeMode> {
  final ThemeRepo _repository;
  GetThemeMode(this._repository);

  @override
  ResultFuture<AppThemeMode> call() => _repository.getThemeMode();
}
