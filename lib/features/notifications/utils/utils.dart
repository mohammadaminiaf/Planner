import 'package:awesome_notifications/awesome_notifications.dart';

void showNotification({
  required String title,
  required String body,
  required String bigPictureUrl,
  required String largeIconUrl,
  required DateTime dateTime,
}) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  String utcTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  final currentTime = DateTime.now();
  final difference = dateTime.difference(currentTime).inSeconds;

  AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.KeepOnTop,
          title: title,
          body: body,
          customSound: 'asset://assets/sounds/notifications.mp3',
          bigPicture: 'asset://$bigPictureUrl',
          largeIcon: 'asset://$largeIconUrl',
          notificationLayout: NotificationLayout.BigPicture,
        ),

        /// Using this technique we can sechedule notifications according to the current
        /// time. We can say to dispaly a notification 10 seconds after now and also repeat it
        /// every day (every 86400 secs)
        ///

        // Display a notification at 15:30 o'clock
        // 3:30 - 3:26 = 4
        schedule: NotificationInterval(
          interval: difference,
          allowWhileIdle: true,
          preciseAlarm: true,
          // repeats: true,
          timeZone: localTimeZone,
        ),
      );
      if (!isAllowed) {}
    },
  );
}
