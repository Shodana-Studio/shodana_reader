import 'package:beamer/beamer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

import 'more_about_screen.dart';
import 'more_general_settings_screen.dart';
import 'more_settings_screen.dart';

class MoreDetailsScreen extends HookWidget {
  const MoreDetailsScreen({Key? key, required this.option}) : super(key: key);
  final String option;

  @override
  Widget build(BuildContext context) {
    if (option == 'settings') {
      return const MoreSettingsScreen();
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


}
