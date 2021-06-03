import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';

import 'clubs_screen_mobile.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  void beamToClub(BuildContext context, String club) {
    context.beamToNamed('/clubs/$club');
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = context.authNotifier?.status ?? AuthStatus.uninitialized;
    if (authStatus != AuthStatus.authenticated) {
      return const Center(child: CircularProgressIndicator(),);
    }
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ClubsScreenMobile(
        beamToClub: beamToClub,
      ),
      tablet: (BuildContext context) => ClubsScreenMobile(
        beamToClub: beamToClub,
      ),
      desktop: (BuildContext context) => ClubsScreenMobile(
        beamToClub: beamToClub,
      ),
      watch: (BuildContext context) => ClubsScreenMobile(
        beamToClub: beamToClub,
      ),
    );
  }
}