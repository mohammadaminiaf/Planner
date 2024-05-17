import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';
import '/core/utils/utils.dart';
import '/features/notifications/enums/notification_enum.dart';
import '/features/notifications/presentation/widgets/select_notification_widget.dart';
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
    required this.onNotifyAtChanged,
    required this.onNotificationScheduleChanged,
    required this.resetIf,
    required this.priority,
    required this.startDate,
    required this.notifyAt,
    required this.notificationSchedule,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ValueChanged<TaskPriority> onPrioirtyChanged;
  final ValueChanged<DateTime?> onStartDateChanged;
  final ValueChanged<DateTime?> onNotifyAtChanged;
  final ValueChanged<String?> onNotificationScheduleChanged;
  final bool Function() resetIf;
  final TaskPriority priority;
  final DateTime startDate;
  final DateTime? notifyAt;
  final String? notificationSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          label: 'Date: ',
          onPickDate: onStartDateChanged,
        ),

        const SizedBox(height: 20),

        // Show Notification
        const Text('Show Notifications At: '),

        const SizedBox(height: 10),

        SelectNotificationWidget(
          resetIf: resetIf,
          onSelected: (NotificationEnum item) {
            /// Since notification is shown before the task's start date
            /// I'm gonna check the task's start date and show notification
            /// before that (according to the selected index)

            final minutesBeforeStartDate = item.durationInMinutes;

            final notifyAt = startDate.subtract(
              Duration(minutes: minutesBeforeStartDate),
            );

            onNotifyAtChanged(notifyAt);
            onNotificationScheduleChanged(item.name);
          },
          values: NotificationEnum.values,
          selectedButtonColor: Colors.red,
          unselectedButtonColor: Colors.red.shade200,
          selectedValue: pickSelectedValue(),
        ),
      ],
    );
  }

  NotificationEnum? pickSelectedValue() {
    if (notificationSchedule != null) {
      if (notifyAt != null && notifyAt!.isAfter(DateTime.now())) {
        return NotificationEnum.fromStringToEnum(notificationSchedule!);
      }
    }
    return null;
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
