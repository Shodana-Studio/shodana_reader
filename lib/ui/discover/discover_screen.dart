import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'discover_screen_mobile.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  void beamToInternetBook(BuildContext context, String book) {
    context.beamToNamed('/discover/$book');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DiscoverScreenMobile(
        beamToInternetBook: beamToInternetBook,
      ),
      tablet: (BuildContext context) => DiscoverScreenMobile(
        beamToInternetBook: beamToInternetBook,
      ),
      desktop: (BuildContext context) => DiscoverScreenMobile(
        beamToInternetBook: beamToInternetBook,
      ),
      watch: (BuildContext context) => DiscoverScreenMobile(
        beamToInternetBook: beamToInternetBook,
      ),
    );
  }
}