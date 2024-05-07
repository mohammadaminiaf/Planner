import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/core/screens/home_screen.dart';
import 'package:planner/features/tasks/presentation/screens/tasks_screen.dart';

import '/core/screens/error_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _cupertinoRoute(
          const HomeScreen(),
        );

      case TasksScreen.routeName:
        return _cupertinoRoute(
          const TasksScreen(),
        );

      default:
        return _cupertinoRoute(
          ErrorScreen(error: 'Wrong Route provided ${settings.name}'),
        );
    }
  }

  // Build material routes for views
  static Route _materialRoute(Widget view) => MaterialPageRoute(
        builder: (_) => view,
      );

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}
