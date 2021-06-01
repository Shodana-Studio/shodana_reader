import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../app_screen/provider/bottom_navigation_provider.dart';
import 'more_about/more_about_screen.dart';
import 'more_screen_mobile.dart';
import 'more_settings/more_settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  void settingsOnPressed(BuildContext context) {
    // context.beamToNamed('/more/settings');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const MoreSettingsScreen();
        })
    );
  }

  void aboutOnPressed(BuildContext context) {
    // context.beamToNamed('/more/about');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const AboutScreen();
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.authNotifier?.user;
    return WillPopScope(
      onWillPop: () async {
        context.read(shouldShowBottomNavigationProvider).state = true;
        return true;
      },
      child: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => MoreScreenMobile(
          settingsOnPressed: () => settingsOnPressed(context),
          aboutOnPressed: () => aboutOnPressed(context),
          user: user,
        ),
        tablet: (BuildContext context) => MoreScreenMobile(
          settingsOnPressed: () => settingsOnPressed(context),
          aboutOnPressed: () => aboutOnPressed(context),
          user: user,
        ),
        desktop: (BuildContext context) => MoreScreenMobile(
          settingsOnPressed: () => settingsOnPressed(context),
          aboutOnPressed: () => aboutOnPressed(context),
          user: user,
        ),
        watch: (BuildContext context) => MoreScreenMobile(
          settingsOnPressed: () => settingsOnPressed(context),
          aboutOnPressed: () => aboutOnPressed(context),
          user: user,
        ),
      ),
    );
  }
}

