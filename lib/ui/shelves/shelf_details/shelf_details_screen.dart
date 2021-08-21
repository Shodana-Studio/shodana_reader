import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'shelf_details_screen_mobile.dart';

class ShelfDetailsScreen extends StatelessWidget {
  const ShelfDetailsScreen({Key? key, required this.shelf}) : super(key: key);
  final Map<String, String> shelf;

  void beamToBook(BuildContext context, String shelf, String book) {
    context.beamToNamed('/shelves/$shelf/$book');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
      ),
      tablet: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
      ),
      desktop: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
      ),
      watch: (BuildContext context) => ShelfDetailsScreenMobile(
        beamToBook: beamToBook,
        shelf: shelf,
      ),
    );
  }
}