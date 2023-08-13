import 'package:flutter/material.dart';

import '/app/theme/app_colors.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.secondary.withAlpha(100),
      height: 10,
      thickness: 2,
    );
  }
}
