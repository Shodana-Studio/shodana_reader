import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';
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
          SettingsSection(
            title: '\nTheme',
            tiles: const [],
          ),
          SettingsTile(
            title: 'Dark mode',
            subtitle: 'Follow system',
            onPressed: (BuildContext context) {},
          ),
          SettingsTile(
            title: 'Light theme',
            subtitle: 'Default',
            onPressed: (BuildContext context) {},
          ),
          SettingsTile(
            title: 'Dark theme',
            subtitle: 'Default',
            onPressed: (BuildContext context) {},
          ),
        ],
      ),
    );
  }

  void showDarkModeDialog() {

  }
}