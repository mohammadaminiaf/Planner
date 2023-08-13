import 'package:flutter/material.dart';

import '/app/theme/app_colors.dart';

@immutable
class OptionDialogModel<T> {
  final String title;
  final Map<String, T> options;
  final T? selectedOption;

  const OptionDialogModel({
    required this.title,
    required this.options,
    this.selectedOption,
  });
}

extension Present<T> on OptionDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: options.entries
              .map(
                (entry) => RadioListTile<T>(
                  title: Text(entry.key),
                  value: entry.value,
                  groupValue: selectedOption,
                  onChanged: (option) {
                    Navigator.of(context).pop(option);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}
