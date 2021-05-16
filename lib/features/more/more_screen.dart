import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.morePageTitle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.settingsButtonText),
            leading: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () => context.beamToNamed('/more/settings'),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.aboutButtonText),
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