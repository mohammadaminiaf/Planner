import 'package:flutter/material.dart';

import '/core/components/option_dialog_model.dart';

@immutable
class SelectLanguageDialog extends OptionDialogModel<String> {
  SelectLanguageDialog({
    required String? currentLanguage,
  }) : super(
          title: 'Languages',
          selectedOption: currentLanguage,
          options: {
            'English': 'en',
            'فارسی': 'fa',
          },
        );
}
