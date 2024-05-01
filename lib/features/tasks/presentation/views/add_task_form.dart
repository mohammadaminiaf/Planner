import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';
import '/core/utils/utils.dart';
import '/features/tasks/data/models/task_priority.dart';
import '/features/tasks/presentation/widgets/description_text_field.dart';
import '/features/tasks/presentation/widgets/priority_dropdown_button.dart';
import '/features/tasks/presentation/widgets/title_text_field.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onPrioirtyChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.priority,
    required this.startDate,
    required this.endDate,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ValueChanged<TaskPriority> onPrioirtyChanged;
  final ValueChanged<DateTime?> onStartDateChanged;
  final ValueChanged<DateTime?> onEndDateChanged;
  final TaskPriority priority;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Title text form field
        TitleTextField(
          controller: titleController,
        ),
        //! Description text form field
        DescriptionTextField(
          controller: descriptionController,
        ),
        const SizedBox(height: 20),
        //! Priority Dropdown button
        PriorityDropdownButton(
          onChanged: (value) => onPrioirtyChanged(value as TaskPriority),
          priority: priority,
        ),
        //! Start Date Picker
        PickDateWidget(
          dateTime: startDate.format(),
          label: 'Start Date: ',
          onPickDate: onStartDateChanged,
        ),
        PickDateWidget(
          dateTime: endDate.format(),
          label: 'End Date: ',
          onPickDate: onEndDateChanged,
        ),
      ],
    );
  }
}

class PickDateWidget extends StatelessWidget {
  const PickDateWidget({
    super.key,
    required this.dateTime,
    required this.label,
    required this.onPickDate,
  });

  final String dateTime;
  final String label;
  final ValueChanged<DateTime?> onPickDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          InkWell(
            onTap: () async {
              // pick current date using pickDateTime method we defined in utils
              final pickedDate = await pickDateTime(context: context);

              // Trigger onPickedDate to send data backwards to form widget
              onPickDate(pickedDate);
            },
            child: Text(dateTime),
          ),
        ],
      ),
    );
  }
}
