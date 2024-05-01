import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.descriptions,
      ),
      onSaved: (description) => controller.text = description!,
    );
  }
}
