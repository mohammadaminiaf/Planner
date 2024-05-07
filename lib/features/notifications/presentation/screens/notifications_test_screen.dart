import 'package:flutter/material.dart';
import '/features/notifications/utils/utils.dart';

class NotificationsTest extends StatefulWidget {
  const NotificationsTest({super.key});

  @override
  State<NotificationsTest> createState() => _NotificationsTestState();
}

class _NotificationsTestState extends State<NotificationsTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            ElevatedButton(
              onPressed: () {
                showNotification(
                  title: 'Task Time',
                  body: 'Task needs to be perfomed or ignored',
                  bigPictureUrl: 'assets/images/splash.jfif',
                  largeIconUrl: 'assets/icons/icon3.png',
                  dateTime: DateTime.now(),
                );
              },
              child: const Text('Show Notifications'),
            ),
          ],
        ),
      ),
    );
  }
}
