import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'shelf_details_screen_mobile.dart';

class ShelfDetailsScreen extends StatelessWidget {
  const ShelfDetailsScreen({Key? key, required this.shelf, required this.rootContext}) : super(key: key);
  final Map<String, String> shelf;
  final BuildContext rootContext;

  void beamToBook(BuildContext context, String shelf, String book) {
    context.beamToNamed('/shelves/$shelf/$book');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
        rootContext: rootContext
      ),
      tablet: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
        rootContext: rootContext
      ),
      desktop: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
        rootContext: rootContext
      ),
      watch: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
        rootContext: rootContext
      ),
    );
  }
}