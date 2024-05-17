import 'package:flutter/material.dart';

import '/features/notifications/enums/notification_enum.dart';

class SelectNotificationWidget extends StatefulWidget {
  const SelectNotificationWidget({
    super.key,
    required this.onSelected,
    required this.resetIf,
    required this.values,
    this.selectedButtonColor = Colors.grey,
    this.unselectedButtonColor = Colors.black54,
    this.selectedValue,
  });

  final ValueChanged<NotificationEnum> onSelected;
  final bool Function() resetIf;
  final List<NotificationEnum> values;
  final Color? selectedButtonColor;
  final Color? unselectedButtonColor;
  final NotificationEnum? selectedValue;

  @override
  State<SelectNotificationWidget> createState() =>
      _SelectNotificationWidgetState();
}

class _SelectNotificationWidgetState extends State<SelectNotificationWidget> {
  NotificationEnum? _selectedValue;
  late final List<NotificationEnum> values;

  @override
  void initState() {
    values = widget.values;

    if (widget.selectedValue != null) {
      _selectedValue = widget.selectedValue!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: values
                .map(
                  (NotificationEnum item) => Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.onSelected(item);
                        if (widget.resetIf() == true) {
                          setState(() => _selectedValue = null);
                        } else {
                          setState(() => _selectedValue = item);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedValue == item
                              ? widget.selectedButtonColor
                              : widget.unselectedButtonColor,
                          border: Border(
                            right: item.index == values.length - 1
                                ? const BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  )
                                : const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            item.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
