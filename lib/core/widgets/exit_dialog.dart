import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:planner/core/widgets/empty_rounded_button.dart';
import 'package:planner/core/widgets/filled_rounded_button.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

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
                  Icons.warning,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.exitDialogTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.exitDialogContent,
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
                  title:
                      AppLocalizations.of(context)!.exitDialogPositiveRespond,
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemNavigator.pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledRoundedButton(
                  title:
                      AppLocalizations.of(context)!.exitDialogNegativeRespond,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
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

/*
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.exitDialogTitle,
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppLocalizations.of(context)!.exitDialogContent,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
        top: 15,
      ),
      actionsPadding: const EdgeInsets.only(top: 0),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.exitDialogNegativeRespond,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
          child: Text(
            AppLocalizations.of(context)!.exitDialogPositiveRespond,
          ),
        ),
      ],
    );

*/