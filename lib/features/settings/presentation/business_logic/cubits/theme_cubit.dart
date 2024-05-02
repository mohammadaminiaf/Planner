import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/usecase/usecases.dart';
import '/features/settings/constants/constants.dart';
import '/features/settings/domain/usecases/change_theme_usecase.dart';
import '/features/settings/domain/usecases/get_current_theme_usecase.dart';

typedef AppThemeMode = String;

class ThemeCubit extends Cubit<AppThemeMode> {
  final ChangeThemeUsecase changeThemeUsecase;
  final GetCurrentThemeUsecase getCurrentThemeUsecase;

  ThemeCubit({
    required this.changeThemeUsecase,
    required this.getCurrentThemeUsecase,
  }) : super(systemTheme) {
    _fetchCurrentTheme();
  }

  static String get systemTheme => ThemeMode.system == ThemeMode.light
      ? Constants.lightTheme
      : Constants.darkTheme;

  Future<void> _fetchCurrentTheme() async {
    final themeMode = await getCurrentThemeUsecase(NoParams());
    // Directly emit themeMode string instead of ThemeMode
    emit(themeMode);
  }

  Future<void> changeTheme({required String themeMode}) async {
    await changeThemeUsecase(themeMode);
    emit(themeMode);
  }

  Future<AppThemeMode> getCurrentThemeMode() async {
    final themeMode = await getCurrentThemeUsecase(NoParams());
    return themeMode;
  }
}
