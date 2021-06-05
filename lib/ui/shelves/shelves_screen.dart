import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'shelves_screen_mobile.dart';

class ShelvesScreen extends StatelessWidget {
  const ShelvesScreen({Key? key, required this.rootContext}) : super(key: key);
  final BuildContext rootContext;

  void beamToShelf(BuildContext context, String shelf) {
    context.beamToNamed('/shelves/$shelf}');
  }

  void beamToBook(BuildContext context, String shelf, String book) {
    context.beamToNamed('/shelves/$shelf/$book');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ShelvesScreenMobile(
        beamToShelf: beamToShelf,
        beamToBook: beamToBook,
        rootContext: rootContext
      ),
      tablet: (BuildContext context) => ShelvesScreenMobile(
        beamToShelf: beamToShelf,
        beamToBook: beamToBook,
        rootContext: rootContext
      ),
      desktop: (BuildContext context) => ShelvesScreenMobile(
        beamToShelf: beamToShelf,
        beamToBook: beamToBook,
        rootContext: rootContext
      ),
      watch: (BuildContext context) => ShelvesScreenMobile(
        beamToShelf: beamToShelf,
        beamToBook: beamToBook,
        rootContext: rootContext
      ),
    );
  }
}

