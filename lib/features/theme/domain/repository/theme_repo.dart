abstract class ThemeRepo {
  const ThemeRepo();

  bool isDarkTheme();
  void changeTheme({required bool isDark});
}
