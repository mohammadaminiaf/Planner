import '/core/usecase/usecases.dart';
import '/features/settings/domain/repository/settings_repository.dart';

class ChangeThemeUsecase extends Usecase<String, String> {
  final SettingsRepository settingsRepository;
  ChangeThemeUsecase(this.settingsRepository);

  @override
  Future<String> call(String param) {
    return settingsRepository.changeTheme(param);
  }
}
