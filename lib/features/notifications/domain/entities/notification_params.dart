import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class NotificationParams extends Equatable {
  final String title;
  final String body;
  final String bigPictureUrl;
  final String largeIconUrl;
  final DateTime startAt;

  const NotificationParams({
    required this.title,
    required this.body,
    required this.bigPictureUrl,
    required this.largeIconUrl,
    required this.startAt,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        bigPictureUrl,
        largeIconUrl,
        startAt,
      ];
}
