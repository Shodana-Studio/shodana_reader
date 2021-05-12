import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../screens/more/more_screen.dart';

class MoreLocation extends BeamLocation {
  MoreLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/more/:itemId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:

    BeamPage(
      key: const ValueKey('more'),
      child: const MoreScreen(),
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