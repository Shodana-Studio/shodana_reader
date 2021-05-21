import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'more_general_settings_list.dart';

class MoreGeneralSettingsScreenMobile extends StatelessWidget {
  const MoreGeneralSettingsScreenMobile({
    Key? key,
    required this.leftRail,
    required this.followSysTheme,
    required this.darkMode,
  }) : super(key: key);

  final bool leftRail;
  final bool followSysTheme;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.generalPageTitle),
      ),
      body: GeneralSettingsList(leftRail: leftRail, followSysTheme: followSysTheme, darkMode: darkMode),
    );
  }
}