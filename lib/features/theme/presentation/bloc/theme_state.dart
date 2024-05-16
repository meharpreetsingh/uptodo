part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeDarkState extends ThemeState {}

final class ThemeLightState extends ThemeState {}
