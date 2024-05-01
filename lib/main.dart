import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:planner/app/theme/app_theme.dart';
import 'package:planner/features/settings/constants/constants.dart';

import '/core/screens/home_screen.dart';
import '/features/settings/presentation/business_logic/cubits/locale_cubit.dart';
import '/features/settings/presentation/business_logic/cubits/theme_cubit.dart';
import '/features/tasks/presentation/bloc/tasks_bloc.dart';
import '/l10n/l10n.dart';
import '/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init locator
  await setup();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                home: const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
