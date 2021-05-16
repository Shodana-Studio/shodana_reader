import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:beamer/beamer.dart';

class MoreSettingsScreen extends StatelessWidget {
  const MoreSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settingsPageTitle)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.generalButtonText),
            leading: Icon(
              Icons.tune,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () =>
                context.beamToNamed('/more/settings/general'),
          ),
        ],
      ),
    );
  }
}
