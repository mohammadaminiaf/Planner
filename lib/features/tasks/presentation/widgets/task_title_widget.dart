import 'package:flutter/material.dart';

class TaskTitleWidget extends StatelessWidget {
  const TaskTitleWidget({
    super.key,
    required this.isDone,
    required this.title,
  });

  final bool isDone;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
        decoration: isDone ? TextDecoration.lineThrough : null,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2,
      ),
    );
  }
}
