import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/theme/domain/entity/app_theme_mode.dart';
import 'package:uptodo/features/theme/domain/repository/theme_repo.dart';

class SetThemeMode extends UsecaseWithParams<void, AppThemeMode> {
  final ThemeRepo _repository;
  SetThemeMode(this._repository);

  @override
  ResultVoid call(AppThemeMode params) => _repository.setThemeMode(params);
}
