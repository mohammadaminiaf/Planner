import 'package:flutter/material.dart';

class AppTheme {
  //! Light theme colors
  static const primaryLight = Colors.black;
  static const secondaryLight = Colors.grey;

  //! Dark theme colors
  static const primaryDark = Colors.white;
  static const secondaryDark = Colors.grey;

  static final lightTheme = ThemeData.light().copyWith();

  static final darkTheme = ThemeData.dark().copyWith();
}


//! Big Flutter bug
/*
When I set a primary color or use a colorScheme in the themes I get an error 
and the error is that the platofrm fails ot identify the current theme of the app
The theme changes to dark but the button still assumes that it's light theme so it
stays inactive (Dark Theme Mode Button).

The way the button works is by checking the value provided for current theme in shared_preferences
It everytime you change the theme it stores / updates value of current_theme variable in shared_preferences
also also everytime the cubit asks, it gets the value from shared_preferences.
*/