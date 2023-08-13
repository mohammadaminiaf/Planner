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
        color: isDone ? Colors.grey : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
