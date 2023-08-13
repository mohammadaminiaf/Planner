import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/providers/tasks_provider.dart';
import '/core/widgets/empty_rounded_button.dart';
import '/core/widgets/filled_rounded_button.dart';

class DeleteDialog extends StatelessWidget {
  final String id;
  final int index;

  const DeleteDialog({
    super.key,
    required this.id,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 25,
                child: Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deleteDialogTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.deleteDialogContent,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: EmptyRoundedButton(
                  title: AppLocalizations.of(context)!.cancel,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return FilledRoundedButton(
                      title: AppLocalizations.of(context)!.delete,
                      color: Colors.red,
                      onPressed: () {
                        ref.read(tasksProvider.notifier).deleteTask(id, index);
                        Navigator.pop(context, true);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
