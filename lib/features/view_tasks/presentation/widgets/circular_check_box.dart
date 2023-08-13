import 'package:flutter/material.dart';
import 'package:planner/app/theme/app_colors.dart';

class CircularCheckBox extends StatefulWidget {
  CircularCheckBox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  bool isChecked;
  final void Function(bool? value) onChanged;

  @override
  State<CircularCheckBox> createState() => _CircularCheckBoxState();
}

class _CircularCheckBoxState extends State<CircularCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isChecked = !widget.isChecked;
        widget.onChanged(widget.isChecked);
        setState(() {});
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isChecked ? AppColors.blurredGrey : Colors.transparent,
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
