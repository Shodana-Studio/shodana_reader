import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    Key? key,
    required this.settingsOnPressed,
    required this.aboutOnPressed}) : super(key: key);
  final VoidCallback settingsOnPressed;
  final VoidCallback aboutOnPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.settingsButtonText),
          leading: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).primaryColor,
          ),
          onTap: settingsOnPressed,
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.aboutButtonText),
          leading: Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColor,
          ),
          onTap: aboutOnPressed,
        ),
      ],
    );
  }
}
