import 'package:flutter/material.dart';
import 'package:planner/app/theme/app_colors.dart';

class TaskSubtitleWidget extends StatelessWidget {
  const TaskSubtitleWidget({
    Key? key,
    required this.subtitle,
    required this.isChecked,
  }) : super(key: key);

  final String subtitle;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 14,
        color: isChecked ? AppColors.blurredGrey : AppColors.secondary,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
