import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          ListTile(
            title: const Text('Settings'),
            leading: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () => context.beamToNamed('/more/settings'),
          ),
          ListTile(
            title: const Text('About'),
            leading: Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () => context.beamToNamed('/more/about'),
          ),
        ],
      ),
    );
  }
}