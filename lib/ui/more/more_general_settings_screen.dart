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
        title: Text(AppLocalizations.of(context)!.generalPageTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          SettingsSection(
            title: AppLocalizations.of(context)!.themeSectionText,
            tiles: const [],
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.darkModeSwitchText),
            onChanged: (bool value) {
              context.read(darkModeSwitchProvider.notifier).toggle();
              if (!followSysTheme) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              }
            },
            value: darkMode,
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.followSysThemeSwitchText),
            subtitle: Text(AppLocalizations.of(context)!.followSysThemeSwitchSubtitle),
            onChanged: (bool value) {
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
            value: followSysTheme,
          ),
          const Divider(height: 1.0),
        ],
      ),
    );
  }
}