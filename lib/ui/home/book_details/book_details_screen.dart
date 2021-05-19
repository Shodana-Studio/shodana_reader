import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../data/provider/bottom_navigation_provider.dart';
import 'book_details_screen_mobile.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Map<String, String> book;

  Future<void> startReadingButtonPressed(BuildContext context) async {
    context.read(shouldShowBottomNavigationProvider).state = false;
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // Beam to different locations depending on the current page stack
    if (Beamer.of(context).currentLocation.state
        .pathBlueprintSegments.first == 'shelves') {
      return context.beamToNamed('/shelves/0/0/1}');
    } else {
      return context.beamToNamed('/home/0/1}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
      ),
      tablet: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
      ),
      desktop: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
      ),
      watch: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
      ),
    );
  }
}