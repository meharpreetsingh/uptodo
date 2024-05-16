import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/theme/domain/entity/app_theme_mode.dart';

abstract class ThemeRepo {
  const ThemeRepo();

  ResultVoid setThemeMode(AppThemeMode themeMode);
  ResultFuture<AppThemeMode> getThemeMode();
}
