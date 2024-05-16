import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeDarkState()) {
    on<ThemeEvent>((event, emit) {});
    on<ToggleDarkMode>(_toggleDarkMode);
    on<ToggleLightMode>(_toggleLightMode);
    on<ToggleThemeMode>(_toggleThemeMode);
  }

  FutureOr<void> _toggleDarkMode(ToggleDarkMode event, Emitter<ThemeState> emit) {}

  FutureOr<void> _toggleLightMode(ToggleLightMode event, Emitter<ThemeState> emit) {}

  FutureOr<void> _toggleThemeMode(ToggleThemeMode event, Emitter<ThemeState> emit) {}
}
