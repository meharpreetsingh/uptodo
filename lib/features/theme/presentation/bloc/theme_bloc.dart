import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/theme/domain/entity/app_theme_mode.dart';
import 'package:uptodo/features/theme/domain/usecases/get_theme_mode.dart';
import 'package:uptodo/features/theme/domain/usecases/set_theme_mode.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required GetThemeMode getThemeMode, required SetThemeMode setThemeMode})
      : _getThemeMode = getThemeMode,
        _setThemeMode = setThemeMode,
        super(ThemeDarkState()) {
    on<ThemeEvent>((event, emit) {});
    on<ToggleDarkModeEvent>(_onToggleDarkMode);
    on<ToggleLightModeEvent>(_onToggleLightMode);
    on<ToggleThemeModeEvent>(_onToggleThemeMode);
    on<GetThemeModeEvent>(_onGetThemeMode);
  }

  final GetThemeMode _getThemeMode;
  final SetThemeMode _setThemeMode;

  FutureOr<void> _onToggleDarkMode(ToggleDarkModeEvent event, Emitter<ThemeState> emit) async {
    final result = await _setThemeMode(AppThemeMode.dark);
    result.fold(
      (failure) => emit(ThemeErrorState(failure.message)),
      (_) => emit(ThemeDarkState()),
    );
  }

  FutureOr<void> _onToggleLightMode(ToggleLightModeEvent event, Emitter<ThemeState> emit) async {
    final result = await _setThemeMode(AppThemeMode.light);
    result.fold(
      (failure) => emit(ThemeErrorState(failure.message)),
      (_) => emit(ThemeLightState()),
    );
  }

  FutureOr<void> _onToggleThemeMode(ToggleThemeModeEvent event, Emitter<ThemeState> emit) async {
    final result = await _getThemeMode();
    result.fold(
      (failure) => emit(ThemeErrorState(failure.message)),
      (themeMode) async {
        if (themeMode == AppThemeMode.dark) {
          final result = await _setThemeMode(AppThemeMode.light);
          result.fold(
            (failure) => emit(ThemeErrorState(failure.message)),
            (_) => emit(ThemeLightState()),
          );
        } else {
          final result = await _setThemeMode(AppThemeMode.dark);
          result.fold(
            (failure) => emit(ThemeErrorState(failure.message)),
            (_) => emit(ThemeDarkState()),
          );
        }
      },
    );
  }

  FutureOr<void> _onGetThemeMode(GetThemeModeEvent event, Emitter<ThemeState> emit) async {
    final result = await _getThemeMode();
    result.fold(
      (failure) => emit(ThemeErrorState(failure.message)),
      (themeMode) {
        if (themeMode == AppThemeMode.dark) {
          emit(ThemeDarkState());
        } else {
          emit(ThemeLightState());
        }
      },
    );
  }
}
