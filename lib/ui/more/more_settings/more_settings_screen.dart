import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return ScreenTypeLayout.builder(
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
    );
  }
}
