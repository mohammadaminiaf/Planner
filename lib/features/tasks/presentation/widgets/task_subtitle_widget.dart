import 'package:flutter/material.dart';

import '/app/theme/app_colors.dart';
import '/core/utils/extensions.dart';

class TaskSubtitleWidget extends StatelessWidget {
  const TaskSubtitleWidget({
    Key? key,
    required this.description,
    required this.endDate,
    required this.startDate,
    required this.isChecked,
  }) : super(key: key);

  final String description;
  final DateTime endDate;
  final DateTime startDate;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        description.isEmpty
            ? const SizedBox.shrink()
            : Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: isChecked
                      ? Theme.of(context).textTheme.bodySmall!.backgroundColor
                      : Theme.of(context).textTheme.bodySmall!.color,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
        const SizedBox(height: 5),
        Text(
          '${startDate.format()} - ${endDate.format()}',
          style: TextStyle(
            fontSize: 12,
            color: isChecked
                ? Theme.of(context).textTheme.bodySmall!.backgroundColor
                : Theme.of(context).textTheme.bodySmall!.color,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
