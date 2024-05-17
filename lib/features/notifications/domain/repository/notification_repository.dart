import 'package:flutter/foundation.dart' show immutable;

import '/features/notifications/domain/entities/notification_params.dart';

@immutable
abstract class NotificationRepository {
  Future<void> showNotification(NotificationParams params);
}
