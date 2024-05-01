import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/app/theme/app_colors.dart';

class AddUpdateTaskButton extends StatelessWidget {
  const AddUpdateTaskButton({
    Key? key,
    required this.isAdding,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isAdding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          onPressed != null ? AppColors.primary : AppColors.blurredGrey,
        ),
      ),
      child: Text(
        isAdding
            ? AppLocalizations.of(context)!.add
            : AppLocalizations.of(context)!.update,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
