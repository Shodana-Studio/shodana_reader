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
          leading: Icon(
            Icons.history_toggle_off_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text('Turn on Incognito mode'),
          // subtitle: const Text('Pauses reading history'),
          onTap: () {},
        ),
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
        ListTile(
          title: const Text('Help'),
          leading: Icon(
            Icons.help_outline,
            color: Theme.of(context).primaryColor,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
