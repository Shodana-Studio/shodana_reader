import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../data/local/storage_utils.dart';

final followSystemThemeSwitchProvider =
    StateNotifierProvider<FollowSystemThemeSwitch, bool>((ref) {
  return FollowSystemThemeSwitch();
});

class FollowSystemThemeSwitch extends StateNotifier<bool>{
  FollowSystemThemeSwitch() : super(StorageUtil.getBool('followSystemTheme'));

  void toggle() {
    state = !state;
    StorageUtil.putBool('followSystemTheme', state);
  }
}

class GeneralSettings extends HookWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String startingScreenText = useProvider(startingScreenTextProvider).state;
    final followSysTheme = useProvider(followSystemThemeSwitchProvider);
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
          SettingsTile.switchTile(
            title: 'Follow system theme',
            onToggle: (bool value) {
              context.read(followSystemThemeSwitchProvider.notifier).toggle();
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