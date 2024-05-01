import 'package:flutter/material.dart';

import '/app/theme/app_colors.dart';

class SettingsCategoryTitle extends StatelessWidget {
  const SettingsCategoryTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}
