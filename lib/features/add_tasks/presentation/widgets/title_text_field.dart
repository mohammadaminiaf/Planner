import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 50,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: true,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.title,
      ),
      onSaved: (title) => controller.text = title!,
      validator: (input) => input!.trim().isEmpty
          ? AppLocalizations.of(context)!.titleErrorMessage
          : null,
    );
  }
}
