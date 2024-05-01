import '/core/usecase/usecases.dart';
import '/features/settings/domain/repository/settings_repository.dart';

class GetCurrentThemeUsecase extends Usecase<String, NoParams> {
  final SettingsRepository settingsRepository;
  GetCurrentThemeUsecase(this.settingsRepository);

  @override
  Future<String> call(NoParams param) async {
    return settingsRepository.getCurrentTheme();
  }
}
