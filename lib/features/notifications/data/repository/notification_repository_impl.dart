import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart' show debugPrint, immutable;

import '/features/notifications/domain/entities/notification_params.dart';
import '/features/notifications/domain/repository/notification_repository.dart';

@immutable
class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<void> showNotification(NotificationParams params) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    // String utcTimeZone =
    //     await AwesomeNotifications().getLocalTimeZoneIdentifier();

    final currentTime = DateTime.now();
    int difference = params.startAt.difference(currentTime).inSeconds;

    if (difference < 5) {
      difference = 86400; // 1 day later
    }

    debugPrint(difference.toString());

    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            actionType: ActionType.KeepOnTop,
            title: params.title,
            body: params.body,
            customSound: 'asset://assets/sounds/notifications.mp3',
            bigPicture: 'asset://${params.bigPictureUrl}',
            largeIcon: 'asset://${params.largeIconUrl}',
            notificationLayout: NotificationLayout.BigPicture,
          ),
          schedule: NotificationInterval(
            interval: difference,
            allowWhileIdle: true,
            preciseAlarm: true,
            // repeats: true,
            timeZone: localTimeZone,
          ),
        );
        if (!isAllowed) {
          throw Exception('User has not allowed notifications');
        }
      },
    );
  }
}
