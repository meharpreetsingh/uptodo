part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class GetThemeModeEvent extends ThemeEvent {}

class ToggleDarkModeEvent extends ThemeEvent {}

class ToggleLightModeEvent extends ThemeEvent {}

class ToggleThemeModeEvent extends ThemeEvent {}
