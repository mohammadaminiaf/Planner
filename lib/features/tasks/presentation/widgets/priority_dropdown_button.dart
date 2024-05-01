import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/features/tasks/data/models/task_priority.dart';

class PriorityDropdownButton extends StatefulWidget {
  const PriorityDropdownButton({
    Key? key,
    required this.priority,
    required this.onChanged,
  }) : super(key: key);

  final TaskPriority? priority;
  final void Function(Object? value)? onChanged;

  @override
  State<PriorityDropdownButton> createState() => _PriorityDropdownButtonState();
}

class _PriorityDropdownButtonState extends State<PriorityDropdownButton> {
  TaskPriority? priority;

  @override
  void initState() {
    priority = widget.priority;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final priorities = [
      PriorityItem(AppLocalizations.of(context)!.low, TaskPriority.low),
      PriorityItem(AppLocalizations.of(context)!.medium, TaskPriority.medium),
      PriorityItem(AppLocalizations.of(context)!.high, TaskPriority.high),
    ];

    return DropdownButtonFormField(
      value: priority,
      items: priorities.map(
        (priorityItem) {
          return DropdownMenuItem(
            value: priorityItem.value,
            child: Text(
              priorityItem.title,
            ),
          );
        },
      ).toList(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.priority,
        hintText: AppLocalizations.of(context)!.priority,
      ),
      alignment: Alignment.centerLeft,
      onSaved: (input) => priority,
      // validator: (input) => priority == null
      //     ? AppLocalizations.of(context)!.titleErrorMessage
      //     : null,
    );
  }
}

class PriorityItem {
  final String title;
  final TaskPriority value;

  PriorityItem(this.title, this.value);
}
