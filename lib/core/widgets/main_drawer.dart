import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/app/theme/app_colors.dart';
import '/features/settings/presentation/screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppColors.primary,
        child: ListView(
          children: [
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.settings,
                    icon: Icons.settings,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.tutorial,
                    icon: Icons.workspaces_outline,
                    onClick: () => selectItem(context),
                  ),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.aboutTheApp,
                    icon: Icons.app_settings_alt_sharp,
                    onClick: () => selectItem(context),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClick,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: onClick,
    );
  }
}

void selectItem(BuildContext context) {
  Navigator.pop(context);
}
