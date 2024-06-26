import 'package:flutter/material.dart';

import '/features/tasks/presentation/screens/add_task_screen.dart';

class AddTaskFab extends StatelessWidget {
  const AddTaskFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddTaskScreen(),
          ),
        );
      },
    );
  }
}
