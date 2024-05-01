import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:planner/features/settings/presentation/business_logic/cubits/locale_cubit.dart';

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

Future<DateTime?> pickDateTime({
  required BuildContext context,
}) async {
  final dateTime = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    locale: Locale(context.read<LocaleCubit>().state),
  );

  if (dateTime != null) {
    return dateTime;
  }

  return null;
}
