import 'package:hive/hive.dart';

import '/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<void> changeLocale(String locale) async {
    await Hive.box('settings').put('locale', locale);
  }

  @override
  String? getCurrentLocale() {
    final locale = Hive.box('settings').get('locale') as String?;
    return locale;
  }
}
