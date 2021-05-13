import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/screens/clubs/clubs_screen.dart';

class ClubsLocation extends BeamLocation {
  ClubsLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/clubs/:clubId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:

    BeamPage(
      key: const ValueKey('clubs'),
      child: const ClubsScreen(),
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