import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:stack_trace/stack_trace.dart' as stack_trace;

import '/app/theme/app_colors.dart';
import '/core/screens/app_details_screen.dart';
import '/core/screens/error_screen.dart';
import '/core/screens/loading_screen.dart';
import '/features/add_tasks/data/models/task_priority.dart';
import '/features/add_tasks/domain/entities/task.dart';
import '/features/settings/presentation/providers/current_language_provider.dart';
import '/features/view_tasks/presentation/screens/tasks_screen.dart';
import '/l10n/l10n.dart';
import '/locator.dart';

void main() async {
  // FlutterError.demangleStackTrace = (StackTrace stack) {
  //   if (stack is stack_trace.Trace) return stack.vmTrace;
  //   if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
  //   return stack;
  // };

  WidgetsFlutterBinding.ensureInitialized();
  // init locator
  await setup();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  /// init hive
  Hive.init(appDocumentDir.path);

  /// Register Hive Adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());

  /// run App method
  runApp(
    ProviderScope(
      child: FutureBuilder(
        future: Future.wait([
          Hive.openBox<Task>('tasks'),
          Hive.openBox('settings'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const ErrorScreen();
            } else {
              // Hive.box<Task>('tasks').clear();
              return const MyApp();
            }
          } else {
            return const LoadingScreen();
          }
        },
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final currentLanguage = ref.watch(currentLanguageProvider);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
        ),
        // useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      locale: currentLanguage != null ? Locale(currentLanguage) : null,
      routes: {
        AppDetailsScreen.routeName: (context) => const AppDetailsScreen(),
      },
      home: const TasksScreen(),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
