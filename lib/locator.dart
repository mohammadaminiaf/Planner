import 'package:get_it/get_it.dart';

/// Notifications
import '/features/notifications/domain/repository/notification_repository.dart';
import '/features/notifications/data/repository/notification_repository_impl.dart';
import '/features/notifications/domain/usecases/send_notification_usecase.dart';

/// Settings
import '/features/settings/domain/usecases/change_theme_usecase.dart';
import '/features/settings/domain/usecases/get_current_theme_usecase.dart';
import '/features/settings/data/repository/settings_repository_impl.dart';
import '/features/settings/domain/repository/settings_repository.dart';
import '/features/settings/domain/usecases/change_locale_usecase.dart';
import '/features/settings/domain/usecases/get_current_locale_usecase.dart';

/// Tasks
import '/features/tasks/domain/usecases/get_sorted_tasks_usecase.dart';
import '/features/tasks/data/repository/task_repository_impl.dart';
import '/features/tasks/domain/repository/task_repository.dart';
import '/features/tasks/domain/usecases/add_task_usecase.dart';
import '/features/tasks/domain/usecases/delete_task_usecase.dart';
import '/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import '/features/tasks/domain/usecases/get_completed_tasks_count_usecase.dart';
import '/features/tasks/domain/usecases/get_task_usecase.dart';
import '/features/tasks/domain/usecases/get_tasks_count_usecase.dart';
import '/features/tasks/domain/usecases/toggle_task_usecase.dart';
import '/features/tasks/domain/usecases/update_task_usecase.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  /// repositories
  //! tasks repository
  locator.registerSingleton<TaskRepository>(TaskRepositoryImpl());
  //! settings repository
  locator.registerSingleton<SettingsRepository>(SettingsRepositoryImpl());
  //! notification repository
  locator
      .registerSingleton<NotificationRepository>(NotificationRepositoryImpl());

  //! Tasks Usecases
  locator.registerSingleton<AddTaskUsecase>(AddTaskUsecase(locator()));
  locator.registerSingleton<UpdateTaskUsecase>(UpdateTaskUsecase(locator()));
  locator.registerSingleton<DeleteTaskUsecase>(DeleteTaskUsecase(locator()));
  locator.registerSingleton<MarkTaskAsCompletedUsecase>(
    MarkTaskAsCompletedUsecase(locator()),
  );
  locator.registerSingleton<GetAllTasksUsecase>(GetAllTasksUsecase(locator()));
  locator.registerSingleton<GetTaskUsecase>(GetTaskUsecase(locator()));
  locator.registerSingleton<GetActiveTasksUsecase>(
    GetActiveTasksUsecase(locator()),
  );
  locator.registerSingleton<GetCompletedTasksUsecase>(
    GetCompletedTasksUsecase(locator()),
  );
  locator.registerSingleton<SortTasksUsecase>(
    SortTasksUsecase(locator()),
  );

  //! Settings Usecases
  locator.registerSingleton<ChangeLocaleUsecase>(
    ChangeLocaleUsecase(locator()),
  );
  locator.registerSingleton<GetCurrentLocaleUsecase>(
    GetCurrentLocaleUsecase(locator()),
  );
  locator.registerSingleton<ChangeThemeUsecase>(
    ChangeThemeUsecase(locator()),
  );
  locator.registerSingleton<GetCurrentThemeUsecase>(
    GetCurrentThemeUsecase(locator()),
  );

  //! Notification Usecase
  locator.registerSingleton<SendNotificationUsecase>(
    SendNotificationUsecase(locator()),
  );
}
