import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  // Pick Date First
  final date = await pickDate(context: context);

  if (date == null) throw Exception('No Date Selected');

  // Time Picker
  final time = await pickTime(context: context);

  if (time == null) throw Exception('No Time Selected');

  final dateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  return dateTime;
}

Future<DateTime?> pickDate({
  required BuildContext context,
}) async {
  final date = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    locale: Locale(context.read<LocaleCubit>().state),
  );

  if (date == null) return null;

  return date;
}

Future<TimeOfDay?> pickTime({
  required BuildContext context,
}) async {
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (time == null) return null;

  return time;
}
