part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class SendNotificationEvent extends NotificationEvent {
  final NotificationParams params;

  const SendNotificationEvent(this.params);

  @override
  List<Object> get props => [params];
}
