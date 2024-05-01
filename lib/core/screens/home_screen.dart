import 'package:flutter/material.dart';

import '/features/settings/presentation/screens/settings_screen.dart';
import '/features/tasks/presentation/screens/tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreenIndex = 0;

  final _destinations = const [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final _screens = const [
    TasksScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: _currentScreenIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentScreenIndex = value;
          });
        },
      ),
    );
  }
}
