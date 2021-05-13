import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/screens/shelves/shelves_screen.dart';

class ShelvesLocation extends BeamLocation {
  ShelvesLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/shelves/:shelfId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:

    BeamPage(
      key: const ValueKey('shelves'),
      child: const ShelvesScreen(),
    ),
    // if (state.pathParameters.containsKey('bookId'))
    //   BeamPage(
    //     key: ValueKey('book-${state.pathParameters['bookId']}'),
    //     child: BookDetailsScreen(
    //       bookId: state.pathParameters['bookId'],
    //     ),
    //   ),
  ];
}