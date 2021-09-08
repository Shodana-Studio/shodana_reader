import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/model/app_model.dart';
import '../../app_screen/provider/left_navigation_rail_provider.dart';
import '../more_settings/provider/follow_system_theme_provider.dart';
import 'more_general_settings_screen_mobile.dart';

class GeneralSettings extends HookConsumerWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appModelNotifierProvider);
    final darkMode = appData.darkMode;
    final followSysTheme = ref.watch(followSystemThemeSwitchProvider);
    final bool leftRail = ref.watch(leftNavigationRailProvider);

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