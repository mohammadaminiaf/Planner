import 'package:flutter/material.dart';

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
                // TODO: To show Notification, now you need to use bloc to call the show notification method.
              },
              child: const Text('Show Notifications'),
            ),
          ],
        ),
      ),
    );
  }
}
