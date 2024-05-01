import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/usecase/usecases.dart';
import '/features/settings/domain/usecases/change_locale_usecase.dart';
import '/features/settings/domain/usecases/get_current_locale_usecase.dart';

class LocaleCubit extends Cubit<String> {
  final ChangeLocaleUsecase changeLocaleUsecase;
  final GetCurrentLocaleUsecase getCurrentLocaleUsecase;
  LocaleCubit({
    required this.changeLocaleUsecase,
    required this.getCurrentLocaleUsecase,
  }) : super('en') {
    _fetchCurrentLocale();
  }

  Future<void> _fetchCurrentLocale() async {
    final locale = await getCurrentLocaleUsecase(NoParams());
    emit(locale);
  }

  Future<String> changeLocale({
    required String locale,
  }) async {
    final newLocale = await changeLocaleUsecase(locale);
    emit(newLocale);
    return newLocale;
  }

  Future<String> getCurrentLocale() async {
    final locale = await getCurrentLocaleUsecase(NoParams());
    return locale;
  }
}
