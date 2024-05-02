import 'package:awesome_notifications/awesome_notifications.dart';

void showNotification({
  required String title,
  required String body,
  required String bigPictureUrl,
  required String largeIconUrl,
}) async {
  AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: title,
          body: body,
          customSound: 'asset://assets/sounds/notifications.mp3',
          bigPicture: 'asset://$bigPictureUrl',
          largeIcon: 'asset://$largeIconUrl',
          notificationLayout: NotificationLayout.BigPicture,
        ),
      );
      if (!isAllowed) {}
    },
  );
}
