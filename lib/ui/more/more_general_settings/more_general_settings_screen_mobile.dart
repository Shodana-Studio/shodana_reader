import 'package:flutter/material.dart';
import '../../../my.i18n.dart';
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
        title: Text('General'.i18n),
      ),
      body: GeneralSettingsList(leftRail: leftRail, followSysTheme: followSysTheme, darkMode: darkMode),
    );
  }
}