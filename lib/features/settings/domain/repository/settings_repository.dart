abstract class SettingsRepository {
  Future<void> changeLocale(String locale);
  String? getCurrentLocale();
}
