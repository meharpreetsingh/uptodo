part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ToggleDarkMode extends ThemeEvent {}

class ToggleLightMode extends ThemeEvent {}

class ToggleThemeMode extends ThemeEvent {}
