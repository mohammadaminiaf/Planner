import 'package:flutter/material.dart';

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({
    Key? key,
    required this.onPressed,
    required this.isButtonActive,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isButtonActive;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isButtonActive ? onPressed : null,
      icon: Icon(
        Icons.delete,
        color: isButtonActive ? Colors.red : null,
      ),
    );
  }
}
