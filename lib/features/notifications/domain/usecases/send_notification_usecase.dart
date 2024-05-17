import '/core/usecase/usecases.dart';
import '/features/notifications/domain/entities/notification_params.dart';
import '/features/notifications/domain/repository/notification_repository.dart';

class SendNotificationUsecase extends Usecase<void, NotificationParams> {
  final NotificationRepository notificationRepository;
  SendNotificationUsecase(this.notificationRepository);

  @override
  Future<void> call(NotificationParams param) {
    return notificationRepository.showNotification(param);
  }
}
