import 'package:flutter/material.dart';

const modalDialogBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(16),
    topLeft: Radius.circular(16),
  ),
);

const titleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const bodyTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

// showModalBottomSheet(
// isScrollControlled: true,
// context: context,
// builder: (context) => SingleChildScrollView(
// padding: EdgeInsets.only(
// bottom: MediaQuery.of(context).viewInsets.bottom,
// ),
// child: const AddNewTaskScreen(index: -1),
// keyboardDismissBehavior:
// ScrollViewKeyboardDismissBehavior.manual,
// ),
// );