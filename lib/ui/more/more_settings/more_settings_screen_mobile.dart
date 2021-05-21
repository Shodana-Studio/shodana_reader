import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreSettingsScreenMobile extends StatelessWidget {
  const MoreSettingsScreenMobile({
    Key? key,
    required this.generalOnPressed}) : super(key: key);
  final VoidCallback generalOnPressed;

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
            onTap: generalOnPressed,
          ),
        ],
      ),
    );
  }
}
