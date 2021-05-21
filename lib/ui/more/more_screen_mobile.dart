import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/settings_list.dart';

class MoreScreenMobile extends StatelessWidget {
  const MoreScreenMobile({
    Key? key,
    required this.settingsOnPressed,
    required this.aboutOnPressed,
  }) : super(key: key);
  final VoidCallback settingsOnPressed;
  final VoidCallback aboutOnPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.morePageTitle)),
      body: SettingsList(
        settingsOnPressed: settingsOnPressed,
        aboutOnPressed: aboutOnPressed,
      ),
    );
  }
}