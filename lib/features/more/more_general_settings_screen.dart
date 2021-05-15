import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/settings_item_button.dart';
class GeneralSettings extends HookWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String startingScreenText = useProvider(startingScreenTextProvider).state;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.generalPageTitle
            ?? 'No Title'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0,),
          const Divider(),
          SettingsItemButton(
              key: const ValueKey('dark_mode'),
              text: 'Dark mode',
              secondaryText: 'Follow system',
              onPressed: () {}
          ),
          SettingsItemButton(
              key: const ValueKey('light_theme'),
              text: 'Light theme',
              secondaryText: 'Default',
              onPressed: () {}
          ),
          SettingsItemButton(
              key: const ValueKey('dark_theme'),
              text: 'Dark theme',
              secondaryText: 'Default',
              onPressed: () {}
          ),
          const Divider(),
        ],
      ),
    );
  }
}