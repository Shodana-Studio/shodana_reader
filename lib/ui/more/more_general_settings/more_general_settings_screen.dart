import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/presentation/provider/dark_mode_provider.dart';
import '../../../core/presentation/provider/follow_system_theme_provider.dart';
import '../../app_screen/provider/left_navigation_rail_provider.dart';
import 'more_general_settings_screen_mobile.dart';

class GeneralSettings extends HookWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final followSysTheme = useProvider(followSystemThemeSwitchProvider);
    final darkMode = useProvider(darkModeSwitchProvider);
    final bool leftRail = useProvider(leftNavigationRailProvider);

    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MoreGeneralSettingsScreenMobile(
          leftRail: leftRail,
          followSysTheme: followSysTheme,
          darkMode: darkMode
      ),
      tablet: (BuildContext context) => MoreGeneralSettingsScreenMobile(
          leftRail: leftRail,
          followSysTheme: followSysTheme,
          darkMode: darkMode
      ),
      desktop: (BuildContext context) => MoreGeneralSettingsScreenMobile(
          leftRail: leftRail,
          followSysTheme: followSysTheme,
          darkMode: darkMode
      ),
      watch: (BuildContext context) => MoreGeneralSettingsScreenMobile(
          leftRail: leftRail,
          followSysTheme: followSysTheme,
          darkMode: darkMode
      ),
    );
  }
}