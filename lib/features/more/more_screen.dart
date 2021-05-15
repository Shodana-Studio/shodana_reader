import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/settings_icon_button.dart';

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
          const SizedBox(height: 8.0),
          SettingsIconButton(
              key: const Key('settings'),
              text: 'Settings',
              icon: Icons.settings_outlined,
              onPressed: () => context.beamToNamed('/more/settings')
          ),
          SettingsIconButton(
              key: const Key('about'),
              text: 'About',
              icon: Icons.info_outline,
              onPressed: () => context.beamToNamed('/more/about')
          ),
        ],
      ),
    );
  }
}