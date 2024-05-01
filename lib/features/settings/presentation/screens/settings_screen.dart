import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/components/option_dialog_model.dart';
import '/features/settings/constants/constants.dart';
import '/features/settings/presentation/business_logic/cubits/locale_cubit.dart';
import '/features/settings/presentation/business_logic/cubits/theme_cubit.dart';
import '/features/settings/presentation/widgets/select_language_dialog.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* General
              SettingsCategoryTitle(
                text: AppLocalizations.of(context)!.general,
              ),

              //! Language Option
              BlocBuilder<LocaleCubit, String>(
                builder: (context, state) {
                  final currentLocale = state;
                  return TextButtonWithDetail(
                    onTap: () async {
                      String? currentLanguage =
                          await context.read<LocaleCubit>().getCurrentLocale();
                      final language = await SelectLanguageDialog(
                        currentLanguage: currentLanguage,
                      ).present(context);
                      if (language != null) {
                        context
                            .read<LocaleCubit>()
                            .changeLocale(locale: language);
                      }
                    },
                    title: AppLocalizations.of(context)!.language,
                    subtitle: Text(
                      currentLocale == 'en' ? 'English' : 'فارسی',
                    ),
                  );
                },
              ),
              //! Theme Switch
              BlocBuilder<ThemeCubit, AppThemeMode>(
                builder: (context, state) {
                  final isDarkMode = state == Constants.darkTheme;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dark Mode',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      CupertinoSwitch(
                        value: isDarkMode,
                        onChanged: (value) {
                          final themeMode = value
                              ? Constants.darkTheme
                              : Constants.lightTheme;
                          context
                              .read<ThemeCubit>()
                              .changeTheme(themeMode: themeMode);
                        },
                      ),
                    ],
                  );
                },
              ),
              const SettingsDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
