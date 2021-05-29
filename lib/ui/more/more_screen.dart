import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';

import 'more_screen_mobile.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  void settingsOnPressed(BuildContext context) {
    context.beamToNamed('/more/settings');
  }

  void aboutOnPressed(BuildContext context) {
    context.beamToNamed('/more/about');
  }

  @override
  Widget build(BuildContext context) {
    final user = context.authNotifier?.user;
    return ScreenTypeLayout.builder(
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
    );
  }
}

