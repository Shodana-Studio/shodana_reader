import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../data/provider/dark_mode_provider.dart';
import '../../data/provider/follow_system_theme_provider.dart';

class GeneralSettings extends HookWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final followSysTheme = useProvider(followSystemThemeSwitchProvider);
    final darkMode = useProvider(darkModeSwitchProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.generalPageTitle
            ?? 'No Title'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          SettingsSection(
            title: 'Theme',
            tiles: const [],
          ),
          SettingsTile.switchTile(
            title: 'Dark mode',
            onToggle: (bool value) {
              context.read(darkModeSwitchProvider.notifier).toggle();
              if (!followSysTheme) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              }
            },
            switchValue: darkMode,
          ),
          // SettingsTile(
          //   title: 'Light theme',
          //   subtitle: 'Default',
          //   onPressed: (BuildContext context) {
          //     AdaptiveTheme.of(context).setLight();
          //   },
          // ),
          // SettingsTile(
          //   title: 'Dark theme',
          //   subtitle: 'Default',
          //   onPressed: (BuildContext context) {
          //     AdaptiveTheme.of(context).setDark();
          //   },
          // ),
          SettingsTile.switchTile(
            title: 'Follow system theme',
            subtitle: 'Dark mode setting will be ignored',
            onToggle: (bool value) {
              context.read(followSystemThemeSwitchProvider.notifier).toggle();
              if (value) {
                AdaptiveTheme.of(context).setSystem();
              }
              else {
                if (darkMode) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              }
            },
            switchValue: followSysTheme,
          ),
          const Divider(height: 1.0),
        ],
      ),
    );
  }

  void showDarkModeDialog() {

  }
}