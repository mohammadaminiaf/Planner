import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/app/theme/app_colors.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

void showToastMessage({
  required String text,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.secondary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
