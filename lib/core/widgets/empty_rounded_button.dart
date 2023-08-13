import 'package:flutter/material.dart';

class EmptyRoundedButton extends StatelessWidget {
  const EmptyRoundedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.color,
  });

  final String title;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
