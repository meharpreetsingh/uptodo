import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/core/error/exceptions.dart';

abstract class ThemeLocalDataSource {
  Future<void> setThemeMode(String themeMode);
  Future<String> getThemeMode();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> getThemeMode() async {
    try {
      return sharedPreferences.getString('THEME_MODE') ?? 'dark';
    } catch (e) {
      throw LocalDataException(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> setThemeMode(String themeMode) async {
    try {
      await sharedPreferences.setString('THEME_MODE', themeMode);
    } catch (e) {
      throw LocalDataException(message: e.toString(), statusCode: 404);
    }
  }
}
