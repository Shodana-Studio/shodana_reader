import 'package:flutter/material.dart';

import '../../l10n/my.i18n.dart';
import 'more_about/more_about_screen.dart';
import 'more_general_settings/more_general_settings_screen.dart';
import 'more_settings/more_settings_screen.dart';

class MoreDetailsScreen extends StatelessWidget {
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
      return Scaffold(appBar: AppBar(
        title: Text('Error: Unknown Page'.i18n),
      ));
    }
  }


}
