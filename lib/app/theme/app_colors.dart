import 'package:flutter/material.dart';

import '/features/tasks/data/models/task_priority.dart';

class AppColors {
  static const primary = Colors.red;
  static const secondary = Color.fromARGB(255, 121, 120, 120);
  static const blurredGrey = Color.fromARGB(255, 189, 189, 189);
  static const tertiary = Colors.white;

  //! Priority color
  static const highPriorityColor = Colors.red;
  static const mediumPriorityColor = Colors.blueAccent;
  static const lowPriorityColor = Colors.grey;

  AppColors._();
}

Color getPriorityColor(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.high:
      return AppColors.highPriorityColor;
    case TaskPriority.medium:
      return AppColors.mediumPriorityColor;
    case TaskPriority.low:
      return AppColors.lowPriorityColor;
  }
}
