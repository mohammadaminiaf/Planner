import '/features/settings/domain/repository/settings_repository.dart';

class GetCurrentLocaleUsecase {
  final SettingsRepository settingsRepository;
  GetCurrentLocaleUsecase(this.settingsRepository);

  String? getCurrentLocale() {
    return settingsRepository.getCurrentLocale();
  }
}
