import 'package:flutter/material.dart';

import '/features/add_tasks/presentation/screens/add_task_screen.dart';

class AddTaskFab extends StatelessWidget {
  const AddTaskFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
