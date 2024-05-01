import '/core/usecase/usecases.dart';
import '/features/settings/domain/repository/settings_repository.dart';

class GetCurrentLocaleUsecase extends Usecase<String, NoParams> {
  final SettingsRepository settingsRepository;
  GetCurrentLocaleUsecase(this.settingsRepository);

  @override
  Future<String> call(NoParams param) async {
    return settingsRepository.getCurrentLocale();
  }
}
