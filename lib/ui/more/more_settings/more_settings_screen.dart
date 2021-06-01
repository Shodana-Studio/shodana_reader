import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:beamer/beamer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../app_screen/provider/bottom_navigation_provider.dart';
import '../more_general_settings/more_general_settings_screen.dart';
import 'more_settings_screen_mobile.dart';

class MoreSettingsScreen extends StatelessWidget {
  const MoreSettingsScreen({Key? key}) : super(key: key);

  void generalOnPressed(BuildContext context) {
    // context.beamToNamed('/more/settings/general');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const GeneralSettings();
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read(shouldShowBottomNavigationProvider).state = true;
        return true;
      },
      child: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => MoreSettingsScreenMobile(
          generalOnPressed: () => generalOnPressed(context)
        ),
        tablet: (BuildContext context) => MoreSettingsScreenMobile(
            generalOnPressed: () => generalOnPressed(context)
        ),
        desktop: (BuildContext context) => MoreSettingsScreenMobile(
            generalOnPressed: () => generalOnPressed(context)
        ),
        watch: (BuildContext context) => MoreSettingsScreenMobile(
            generalOnPressed: () => generalOnPressed(context)
        ),
      ),
    );
  }
}
