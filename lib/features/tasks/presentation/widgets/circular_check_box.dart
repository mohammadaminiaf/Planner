import 'package:flutter/material.dart';

import '/app/theme/app_colors.dart';

class CircularCheckBox extends StatefulWidget {
  const CircularCheckBox({
    super.key,
    required this.isChecked,
    required this.priorityColor,
    required this.onChanged,
  });

  final bool isChecked;
  final Color priorityColor;
  final void Function(bool? value) onChanged;

  @override
  State<CircularCheckBox> createState() => _CircularCheckBoxState();
}

class _CircularCheckBoxState extends State<CircularCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Every time the widget is clicked, send the opposite of what was previously returned.
        widget.onChanged(!widget.isChecked);
        setState(() {});
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isChecked ? widget.priorityColor : Colors.transparent,
          border: Border.all(
            color:
                widget.isChecked ? Colors.transparent : AppColors.blurredGrey,
            width: 3,
          ),
        ),
        child: widget.isChecked
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 28,
              )
            : null,
      ),
    );
  }
}
