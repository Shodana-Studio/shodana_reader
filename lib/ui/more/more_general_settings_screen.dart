import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/provider/dark_mode_provider.dart';
import '../../data/provider/follow_system_theme_provider.dart';
import '../app_screen/provider/left_navigation_rail_provider.dart';
import '../app_screen/provider/starting_screen_button_choice.dart';
import '../app_screen/provider/starting_screen_provider.dart';
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

class StartingScreenWidget extends HookWidget {
  const StartingScreenWidget({Key? key}) : super(key: key);
  // int? _value = 0; // TODO: Store in a provider

  @override
  Widget build(BuildContext context) {
    // TODO: set _value to value from SharedPrefs
    // _value = context.read()
    final String screen = useProvider(startingPageProvider(context));
    final String subtitle;
    if (screen == 'last_used') {
      subtitle = AppLocalizations.of(context)!.startingScreenOptionLastUsedText;
    } else if (screen == 'home') {
      subtitle = AppLocalizations.of(context)!.startingScreenOptionHomeText;
    } else if (screen == 'shelves') {
      subtitle = AppLocalizations.of(context)!.startingScreenOptionShelvesText;
    } else if (screen == 'clubs') {
      subtitle = AppLocalizations.of(context)!.startingScreenOptionClubsText;
      // } else if (screen == 'discover') {
      // subtitle = AppLocalizations.of(context)!.startingScreenOptionDiscoverText;
    } else if (screen == 'more') {
      subtitle = AppLocalizations.of(context)!.startingScreenOptionMoreText;//.setPage(4)
    } else {
      debugPrint('Error: Invalid screen id in StartingScreenWidget');
      subtitle = 'Unknown screen';
    }
    return ListTile(
      title: const Text('Starting screen'),
      subtitle: Text(subtitle),
      onTap: () async {
        return onStartingScreenTapped(context)
            .then((screen) {
              context.read(startingPageProvider(context).notifier)
                  .setScreen(screen);
            })
            .onError((error, stackTrace) {
              debugPrint('Starting screen not set');
            });
      },
    );
  }

  Future<String> onStartingScreenTapped(
      BuildContext context) async {
    final StartingScreenButtonChoice groupProvider = context.read
      (startingScreenButtonChoiceProvider.notifier);
    final Map<int, Map<String, String>> options = {
      0: {'last_used': AppLocalizations.of(context)!
        .startingScreenOptionLastUsedText},
      1: {'home': AppLocalizations.of(context)!.startingScreenOptionHomeText},
      2: {'shelves': AppLocalizations.of(context)!
          .startingScreenOptionShelvesText},
      3: {'clubs': AppLocalizations.of(context)!.startingScreenOptionClubsText},
      // 4: {'discover': AppLocalizations.of(context)!
      //     .startingScreenOptionDiscoverText}
      4: {'more': AppLocalizations.of(context)!.startingScreenOptionMoreText},
    };
    return await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Alert Dialog Box'),
        children: [
          for (final MapEntry<int, Map<String, String>> option in options.entries)
            SimpleDialogItem(
              leading: Radio(value: option.key, groupValue: groupProvider.getChoice(),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    groupProvider.setPage(newValue);
                  }
                  Navigator.pop(context, option.value.entries.first.key);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              text: option.value.entries.first.value,
              onPressed: () {
                groupProvider.setPage(option.key);
                Navigator.pop(context, option.value.entries.first.key);
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
