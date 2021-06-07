import 'package:flutter/material.dart';
import '../../../my.i18n.dart';

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
          title: Text('Settings'.i18n),
          leading: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).primaryColor,
          ),
          onTap: settingsOnPressed,
        ),
        ListTile(
          title: Text('About'.i18n),
          leading: Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColor,
          ),
          onTap: aboutOnPressed,
        ),
        ListTile(
          title: Text('Help'.i18n),
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
