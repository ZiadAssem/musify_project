import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  // Update the theme
  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  // Convert the ThemeMode to JSON (for persistence)
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'themeMode': state.toString()};
  }

  // Convert JSON back to ThemeMode (for restoration)
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final theme = json['themeMode'] as String?;
    if (theme != null) {
      switch (theme) {
        case 'ThemeMode.light':
          return ThemeMode.light;
        case 'ThemeMode.dark':
          return ThemeMode.dark;
        case 'ThemeMode.system':
          return ThemeMode.system;
        default:
          return ThemeMode.system;  // default to system theme
      }
    }
    return ThemeMode.system;
  }
}
