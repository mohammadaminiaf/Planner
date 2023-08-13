import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/constants.dart';

class AppDetailsScreen extends StatelessWidget {
  static const routeName = '/app_details';

  const AppDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutTheAppText),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.planner,
                  style: titleTextStyle,
                  textAlign: TextAlign.right,
                ),
                Text(
                  AppLocalizations.of(context)!.plannerExplanation,
                  style: bodyTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.usage,
                  style: titleTextStyle,
                ),
                Text(
                  AppLocalizations.of(context)!.usageExplanation,
                  style: bodyTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.aboutTheAuthors,
                  style: titleTextStyle,
                ),
                Text(
                  AppLocalizations.of(context)!.aboutTheAuthorsDetails,
                  style: bodyTextStyle,
                ),
                const SizedBox(
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
