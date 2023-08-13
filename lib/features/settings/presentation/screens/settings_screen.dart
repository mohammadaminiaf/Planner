import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/components/option_dialog_model.dart';
import '/features/settings/presentation/widgets/select_language_dialog.dart';
import '/features/settings/presentation/providers/current_language_provider.dart';
import '/features/settings/presentation/widgets/settings_category_title.dart';
import '/features/settings/presentation/widgets/settings_divider.dart';
import '/features/settings/presentation/widgets/text_button_with_detail.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* General
            SettingsCategoryTitle(
              text: AppLocalizations.of(context)!.general,
            ),
            Consumer(
              builder: (context, ref, child) {
                final currentLocale = ref.watch(currentLanguageProvider);
                return TextButtonWithDetail(
                  onTap: () async {
                    String? currentLanguage = ref.read(currentLanguageProvider);
                    final language = await SelectLanguageDialog(
                      currentLanguage: currentLanguage,
                    ).present(context);
                    if (language != null) {
                      ref
                          .read(currentLanguageProvider.notifier)
                          .changeLocale(language);
                    }
                  },
                  title: AppLocalizations.of(context)!.language,
                  subtitle: Text(
                    currentLocale == null
                        ? ''
                        : currentLocale == 'en'
                            ? 'English'
                            : 'فارسی',
                  ),
                );
              },
            ),
            const SettingsDivider(),
            //* Other settings will be placed here.
          ],
        ),
      ),
    );
  }
}
