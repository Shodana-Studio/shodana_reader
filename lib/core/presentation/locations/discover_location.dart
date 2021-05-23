import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../ui/discover/discover_screen.dart';
import '../../../ui/discover/internet_book_details/discover_details_screen.dart';
import '../../data/repository/fake_data.dart';

class DiscoverLocation extends BeamLocation {
  DiscoverLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/discover/:itemId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    // TODO:

    BeamPage(
      key: const ValueKey('discover'),
      title: 'Discover - Shodana Reader',
      type: BeamPageType.noTransition,
      child: const DiscoverScreen(),
    ),
    if (state.pathParameters.containsKey('itemId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['itemId']}'),
        child: InternetBookDetailsScreen(
          internetBook: internetBook,
        ),
      ),
  ];
}