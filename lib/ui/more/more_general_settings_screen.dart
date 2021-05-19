import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/data/provider/starting_screen_provider.dart';

import '../../data/provider/dark_mode_provider.dart';
import '../../data/provider/follow_system_theme_provider.dart';
import '../../data/provider/left_navigation_rail_provider.dart';
import 'settings_section_header.dart';

class GeneralSettings extends HookWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final followSysTheme = useProvider(followSystemThemeSwitchProvider);
    final darkMode = useProvider(darkModeSwitchProvider);
    final bool leftRail = useProvider(leftNavigationRailProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.generalPageTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StartingScreenWidget(),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.leftHandedNavigationRailSwitchText),
              // subtitle: Text(leftRail ? AppLocalizations.of(context)!
              //     .leftHandedNavigationRailSubtitleLeftText : AppLocalizations
              //     .of(context)!.leftHandedNavigationRailSubtitleRightText),
              subtitle: Text(AppLocalizations.of(context)!.leftHandedNavigationRailSubtitleLeftText),
              onChanged: (bool value) {
                context.read(leftNavigationRailProvider.notifier).toggle();
              },
              value: leftRail,
            ),
            const Divider(height: 1.0),
            SettingsSectionHeader(
              title: AppLocalizations.of(context)!.themeSectionText,
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
      ),
    );
  }
}

class StartingScreenWidget extends StatefulWidget {
  const StartingScreenWidget({Key? key}) : super(key: key);

  @override
  _StartingScreenWidgetState createState() => _StartingScreenWidgetState();
}

class _StartingScreenWidgetState extends State<StartingScreenWidget> {
  int? _value = 0; // TODO: Store in a provider

  @override
  Widget build(BuildContext context) {
    // TODO: set _value to value from SharedPrefs
    // _value = context.read()
    return ListTile(
      title: const Text('Starting screen'),
      subtitle: Text(context.read(startingPageProvider(context))),
      onTap: () async {
        return onStartingScreenTapped(context)
            .then((screen) {
              context.read(startingPageProvider(context).notifier)
                  .setScreen(screen.value);
            })
            .onError((error, stackTrace) {
              debugPrint('Starting screen not set');
            });
      },
    );
  }

  Future<MapEntry<int, String>> onStartingScreenTapped(BuildContext context)
  async {
    final Map<int, String> options = {
      0: AppLocalizations.of(context)!.startingScreenOptionLastUsedText,
      1: AppLocalizations.of(context)!.startingScreenOptionHomeText,
      2: AppLocalizations.of(context)!.startingScreenOptionShelvesText,
      3: AppLocalizations.of(context)!.startingScreenOptionClubsText,
      // 4: AppLocalizations.of(context)!.startingScreenOptionDiscoverText,
      4: AppLocalizations.of(context)!.startingScreenOptionMoreText,
    };
    return await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Alert Dialog Box'),
        children: [
          for (final MapEntry<int, String> option in options.entries)
            SimpleDialogItem(
              leading: Radio(value: option.key, groupValue: _value,
                onChanged: (int? value) {
                  setState(() => _value = value);
                  Navigator.pop(context, option.value);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              text: option.value,
              onPressed: () {
                setState(() {
                  _value = 0;
                });
                Navigator.pop(context, option.value);
              },
            ),
        ],
      ),
    );
  }
}


class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem({
    Key? key,
    this.leading,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  final Widget? leading;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null)
            leading!,
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 24.0),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
