import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/provider/dark_mode_provider.dart';
import '../../../core/presentation/provider/follow_system_theme_provider.dart';
import '../../../my.i18n.dart';
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
          // Starting Screen
          const StartingScreenWidget(),

          // Left handed navigation rail
          SwitchListTile(
            title: Text('Left handed navigation rail'.i18n),
            subtitle: Text('Show on left side'.i18n),
            onChanged: (bool value) {
              context.read(leftNavigationRailProvider.notifier).toggle();
            },
            value: leftRail,
          ),


          // Theme section
          const Divider(height: 1.0),
          SettingsSectionHeader(
            title: 'Theme'.i18n,
          ),

          // Dark mode toggle
          SwitchListTile(
            title: Text('Dark mode'.i18n),
            onChanged: (bool value) {
              context.read(darkModeSwitchProvider.notifier).toggle();
              if (!followSysTheme) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      systemNavigationBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                      systemNavigationBarDividerColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                      systemNavigationBarIconBrightness: Brightness.light,
                      statusBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                    ),
                  );
                } else {
                  AdaptiveTheme.of(context).setLight();
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      systemNavigationBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                      systemNavigationBarDividerColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                      systemNavigationBarIconBrightness: Brightness.dark,
                      statusBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                  );
                }
              }
            },
            value: darkMode,
          ),
          
          // Follow systen theme switch
          SwitchListTile(
            title: Text('Follow system theme'.i18n),
            subtitle: Text('Dark mode setting will be ignored'.i18n),
            onChanged: (bool value) {
              context.read(followSystemThemeSwitchProvider.notifier).toggle();
              if (value) {
                // final backgroundColor = Theme.of(context).backgroundColor;
                AdaptiveTheme.of(context).setSystem();
                // print(backgroundColor.toString());
                // print(AdaptiveTheme.of(context).lightTheme.backgroundColor.toString());
                // if (backgroundColor == AdaptiveTheme.of(context).lightTheme.backgroundColor) {
                //   SystemChrome.setSystemUIOverlayStyle(
                //     SystemUiOverlayStyle(
                //       systemNavigationBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                //       systemNavigationBarDividerColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                //       systemNavigationBarIconBrightness: Brightness.dark,

                //       statusBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                //       statusBarBrightness: Brightness.light,
                //       statusBarIconBrightness: Brightness.dark,
                //     ),
                //   );
                // } else {
                //   SystemChrome.setSystemUIOverlayStyle(
                //     SystemUiOverlayStyle(
                //       systemNavigationBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                //       systemNavigationBarDividerColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                //       systemNavigationBarIconBrightness: Brightness.light,

                //       statusBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                //       statusBarBrightness: Brightness.dark,
                //       statusBarIconBrightness: Brightness.light,
                //     ),
                //   );
                // }
              }
              else {
                if (darkMode) {
                  AdaptiveTheme.of(context).setDark();
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      systemNavigationBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                      systemNavigationBarDividerColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                      systemNavigationBarIconBrightness: Brightness.light,
                      statusBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                    ),
                  );
                } else {
                  AdaptiveTheme.of(context).setLight();
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      systemNavigationBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                      systemNavigationBarDividerColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                      systemNavigationBarIconBrightness: Brightness.dark,
                      statusBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                  );
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