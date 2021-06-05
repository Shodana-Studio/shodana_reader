import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../app_screen/provider/bottom_navigation_provider.dart';
import 'book_details_screen_mobile.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book, required this.rootContext}) : super(key: key);
  final Map<String, String> book;
  final BuildContext rootContext;

  Future<void> startReadingButtonPressed(BuildContext context) async {
    context.read(shouldShowBottomNavigationProvider).state = false;
    // Beam to different locations depending on the current page stack
    if (Beamer.of(context).currentBeamLocation.state
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
        rootContext: rootContext
      ),
      tablet: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
        rootContext: rootContext
      ),
      desktop: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
        rootContext: rootContext
      ),
      watch: (BuildContext context) => BookDetailsScreenMobile(
        book: book,
        startReadingButtonPressed: startReadingButtonPressed,
        rootContext: rootContext
      ),
    );
  }
}