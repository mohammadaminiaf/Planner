import '/core/usecase/usecases.dart';
import '/features/settings/domain/repository/settings_repository.dart';

class ChangeLocaleUsecase extends Usecase<void, String> {
  final SettingsRepository settingsRepository;
  ChangeLocaleUsecase(this.settingsRepository);

  @override
  Future<void> call(String param) {
    return settingsRepository.changeLocale(param);
  }
}
