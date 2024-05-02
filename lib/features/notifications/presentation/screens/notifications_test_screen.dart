import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '/features/notifications/domain/controllers/notification_controller.dart';
import '/features/notifications/utils/utils.dart';

class NotificationsTest extends StatefulWidget {
  const NotificationsTest({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  @override
  State<NotificationsTest> createState() => _NotificationsTestState();
}

class _NotificationsTestState extends State<NotificationsTest> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    super.initState();
  }

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
