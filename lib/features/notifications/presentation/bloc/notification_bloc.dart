import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/notifications/domain/entities/notification_params.dart';
import '/features/notifications/domain/usecases/send_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final SendNotificationUsecase sendNotificationUsecase;

  NotificationBloc({
    required this.sendNotificationUsecase,
  }) : super(NotificationInitial()) {
    //! Handle Sending Notification
    on<SendNotificationEvent>(
      (event, emit) async {
        await sendNotificationUsecase(event.params);
      },
    );
  }
}
