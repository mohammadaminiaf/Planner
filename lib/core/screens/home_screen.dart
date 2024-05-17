import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/features/settings/presentation/screens/settings_screen.dart';
import '/features/tasks/presentation/screens/tasks_screen.dart';
import '/features/tasks/presentation/widgets/add_task_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreenIndex = 0;
  DateTime? lastPressed;
  bool canPop = false;

  final _destinations = const [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final _screens = const [
    TasksScreen(),
    SettingsScreen(),
  ];

  void shouldPopScreen(bool didPop) async {
    if (didPop) {
      // If back button was allowed
      return;
    }

    // If back button was not allowed
    DateTime now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    bool isWarning =
        lastPressed == null || now.difference(lastPressed!) > maxDuration;

    if (didPop) return;

    if (isWarning) {
      lastPressed = DateTime.now();
      final snackBar = SnackBar(
        content: Text(
          AppLocalizations.of(context)!.closeSnackBarMessage,
        ),
        duration: maxDuration,
      );

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);

      return;
    }

    // Navigator.pop(context);
    SystemNavigator.pop();
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: shouldPopScreen,
      child: Scaffold(
        // Setting this to turn avoid scaffold bg color from going behind the nav bar
        extendBody: true,
        backgroundColor: Colors.red,
        body: _screens[_currentScreenIndex],
        floatingActionButton: const AddTaskFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
          child: NavigationBar(
            destinations: _destinations,
            selectedIndex: _currentScreenIndex,
            onDestinationSelected: (value) {
              setState(() {
                _currentScreenIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
