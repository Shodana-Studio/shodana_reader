import 'package:beamer/beamer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'more_about_screen.dart';
import 'more_general_settings_screen.dart';
import 'widgets/settings_icon_button.dart';


class MoreDetailsScreen extends HookWidget {
  const MoreDetailsScreen({Key? key, required this.option}) : super(key: key);
  final String option;

  @override
  Widget build(BuildContext context) {
    if (option == 'settings') {
      return settings(context);
    }
    else if (option == 'about') {
      return const AboutScreen();
    }
    else if (option == 'general') {
      return const GeneralSettings();
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error: Unknown Page'),
        ),
      );
    }
  }

  Widget settings(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.settingsPageTitle
              ?? 'No Title')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          SettingsIconButton(
              key: const ValueKey('general'),
              text: 'General',
              icon: Icons.tune,
              onPressed: () => context.beamToNamed('/more/settings/general')
          ),
        ],
      ),
    );
  }


}