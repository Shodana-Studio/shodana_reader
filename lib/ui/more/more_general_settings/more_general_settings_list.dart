import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/provider/dark_mode_provider.dart';
import '../../../data/provider/follow_system_theme_provider.dart';
import '../../app_screen/provider/left_navigation_rail_provider.dart';
import '../widgets/settings_section_header.dart';
import 'starting_screen_item.dart';

class GeneralSettingsList extends StatelessWidget {
  const GeneralSettingsList({
    Key? key,
    required this.leftRail,
    required this.followSysTheme,
    required this.darkMode,
  }) : super(key: key);

  final bool leftRail;
  final bool followSysTheme;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}