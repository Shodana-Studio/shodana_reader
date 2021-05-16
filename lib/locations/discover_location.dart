import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../data/repository/fake_data.dart';
import '../ui/discover/discover_details_screen.dart';
import '../ui/discover/discover_screen.dart';

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
    if (state.pathParameters.containsKey('itemId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['itemId']}'),
        child: DiscoverDetailsScreen(
          internetBook: internetBook,
        ),
      ),
  ];
}