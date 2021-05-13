import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/screens/discover/discover_screen.dart';

class DiscoverLocation extends BeamLocation {
  DiscoverLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/discover/:itemId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:

    BeamPage(
      key: const ValueKey('discover'),
      child: const DiscoverScreen(),
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