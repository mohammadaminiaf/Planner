import 'package:flutter/material.dart';

class SaveTaskButton extends StatelessWidget {
  const SaveTaskButton({
    Key? key,
    required this.isButtonActive,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isButtonActive;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isButtonActive ? onPressed : null,
      icon: Icon(
        Icons.save,
        color: isButtonActive ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}
