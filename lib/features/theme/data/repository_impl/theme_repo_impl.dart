import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/theme/data/data_sources/theme_local_data_source.dart';
import 'package:uptodo/features/theme/domain/entity/app_theme_mode.dart';
import 'package:uptodo/features/theme/domain/repository/theme_repo.dart';

class ThemeRepoImpl extends ThemeRepo {
  const ThemeRepoImpl(this._localDataSource);

  final ThemeLocalDataSource _localDataSource;

  @override
  ResultFuture<AppThemeMode> getThemeMode() async {
    try {
      final response = await _localDataSource.getThemeMode();
      if (response == "light") {
        return const Right(AppThemeMode.light);
      } else {
        return const Right(AppThemeMode.dark);
      }
    } catch (e) {
      return Left(LocalDataFailure(statusCode: 404, message: e.toString()));
    }
  }

  @override
  ResultVoid setThemeMode(AppThemeMode themeMode) async {
    try {
      final theme = themeMode == AppThemeMode.light ? "light" : "dark";
      _localDataSource.setThemeMode(theme);
      return const Right(null);
    } catch (e) {
      return Left(LocalDataFailure(statusCode: 404, message: e.toString()));
    }
  }
}
