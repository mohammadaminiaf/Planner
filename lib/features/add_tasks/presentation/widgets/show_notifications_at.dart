import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowNotificationsAt extends StatelessWidget {
  const ShowNotificationsAt({
    Key? key,
    required this.onPressed,
    required this.time,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.showNotificationAt,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(time),
          ),
        ),
      ],
    );
  }
}
