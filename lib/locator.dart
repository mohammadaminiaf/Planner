import 'package:get_it/get_it.dart';

/// Add Tasks
import '/features/add_tasks/data/repository/task_repository_impl.dart';
import '/features/add_tasks/domain/repository/task_repository.dart';
import '/features/add_tasks/domain/usecases/add_task_usecase.dart';
import '/features/add_tasks/domain/usecases/delete_task_usecase.dart';
import '/features/add_tasks/domain/usecases/toggle_task_usecase.dart';
import '/features/add_tasks/domain/usecases/update_task_usecase.dart';

/// Settings
import '/features/settings/data/repository/settings_repository_impl.dart';
import '/features/settings/domain/repository/settings_repository.dart';
import '/features/settings/domain/usecases/get_current_locale_usecase.dart';

/// View Tasks
import '/features/view_tasks/data/repository/tasks_repository_impl.dart';
import '/features/view_tasks/domain/repository/tasks_repository.dart';
import '/features/view_tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'features/settings/domain/usecases/change_locale_usecase.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  /// repositories
  locator.registerSingleton<TaskRepository>(TaskRepositoryImpl());
  //! tasks repository
  locator.registerSingleton<TasksRepository>(TasksRepositoryImpl());
  //! settings repository
  locator.registerSingleton<SettingsRepository>(SettingsRepositoryImpl());

  /// usecases
  locator.registerSingleton<AddTaskUsecase>(AddTaskUsecase(locator()));
  locator.registerSingleton<UpdateTaskUsecase>(UpdateTaskUsecase(locator()));
  locator.registerSingleton<DeleteTaskUsecase>(DeleteTaskUsecase(locator()));
  locator.registerSingleton<ToggleTaskUsecase>(ToggleTaskUsecase(locator()));
  locator.registerSingleton<GetAllTasksUsecase>(GetAllTasksUsecase(locator()));
  //! Settings usecases
  locator.registerSingleton<ChangeLocaleUsecase>(
    ChangeLocaleUsecase(locator()),
  );
  locator.registerSingleton<GetCurrentLocaleUsecase>(
    GetCurrentLocaleUsecase(locator()),
  );
}
