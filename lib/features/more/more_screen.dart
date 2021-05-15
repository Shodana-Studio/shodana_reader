import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.morePageTitle
          ?? 'No Title')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsTile(
          title: 'Settings',
          leading: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: (BuildContext context) =>
              context.beamToNamed('/more/settings'),
          ),
          SettingsTile(
            title: 'About',
            leading: Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: (BuildContext context) =>
                context.beamToNamed('/more/about'),
          ),
        ],
      ),
    );
  }
}