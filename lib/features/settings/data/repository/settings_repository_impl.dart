import 'package:shared_preferences/shared_preferences.dart';

import '/features/settings/constants/constants.dart';
import '/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<String> changeLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.locale, locale);
    return locale;
  }

  @override
  Future<String> getCurrentLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.locale) ?? 'en';
  }

  @override
  Future<String> changeTheme(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.themeMode, themeMode);
    return themeMode;
  }

  @override
  Future<String> getCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.themeMode) ?? 'light';
  }
}
