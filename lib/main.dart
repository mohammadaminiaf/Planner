import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/app/routes/routes.dart';
import '/app/theme/app_theme.dart';
import '/core/screens/home_screen.dart';
import '/features/notifications/domain/controllers/notification_controller.dart';
import '/features/notifications/notifications.dart';
import '/features/settings/constants/constants.dart';
import '/features/settings/presentation/business_logic/cubits/locale_cubit.dart';
import '/features/settings/presentation/business_logic/cubits/theme_cubit.dart';
import '/features/tasks/presentation/bloc/tasks_bloc.dart';
import '/l10n/l10n.dart';
import '/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init locator
  await setup();
  setupNotifications();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(
            changeThemeUsecase: locator(),
            getCurrentThemeUsecase: locator(),
          ),
        ),
        BlocProvider(
          create: (context) => LocaleCubit(
            changeLocaleUsecase: locator(),
            getCurrentLocaleUsecase: locator(),
          ),
        ),
        BlocProvider(
          create: (context) => TasksBloc(
            addTaskUsecase: locator(),
            deleteTaskUsecase: locator(),
            getAllTasksUsecase: locator(),
            getTaskUsecase: locator(),
            updateTaskUsecase: locator(),
            markTaskAsCompletedUsecase: locator(),
            getActiveTasksUsecase: locator(),
            getCompletedTasksUsecase: locator(),
            sortTaskUsecase: locator(),
          ),
        ),
      ],
      child: BlocBuilder<LocaleCubit, String>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, AppThemeMode>(
            builder: (context, theme) {
              final themeMode = theme == Constants.lightTheme
                  ? ThemeMode.light
                  : ThemeMode.dark;
              return MaterialApp(
                // The navigator key is necessary to allow to navigate through static methods
                navigatorKey: MyApp.navigatorKey,

                title: MyApp.name,
                color: MyApp.mainColor,

                // onGenerateInitialRoutes: (route) => [
                //   CupertinoPageRoute(
                //     builder: (_) => const HomeScreen(),
                //   ),
                // ],

                initialRoute: '/',
                onGenerateRoute: Routes.onGenerateRoute,

                // Just to separate notification from ui

                themeMode: themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                locale: Locale(locale),
                // home: const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
