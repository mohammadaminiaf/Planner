import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner/locator.dart';

import '/features/settings/domain/usecases/change_locale_usecase.dart';
import '/features/settings/domain/usecases/get_current_locale_usecase.dart';

class CurrentLanguageNotifier extends StateNotifier<String?> {
  final ChangeLocaleUsecase changeLocaleUsecase;
  final GetCurrentLocaleUsecase getCurrentLocaleUsecase;

  CurrentLanguageNotifier({
    required this.changeLocaleUsecase,
    required this.getCurrentLocaleUsecase,
  }) : super(null) {
    state = getCurrentLocaleUsecase.getCurrentLocale();
  }

  Future<void> changeLocale(String locale) async {
    changeLocaleUsecase(locale);
    state = locale;
  }
}

final currentLanguageProvider =
    StateNotifierProvider<CurrentLanguageNotifier, String?>(
  (_) => CurrentLanguageNotifier(
    changeLocaleUsecase: locator(),
    getCurrentLocaleUsecase: locator(),
  ),
);
