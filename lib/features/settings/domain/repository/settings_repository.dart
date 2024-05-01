abstract class SettingsRepository {
  Future<String> changeLocale(String locale);
  Future<String> getCurrentLocale();

  Future<String> changeTheme(String themeMode);
  Future<String> getCurrentTheme();
}
