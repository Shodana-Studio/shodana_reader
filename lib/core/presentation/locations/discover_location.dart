import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../ui/discover/discover_screen.dart';
import '../../../ui/discover/internet_book_details/discover_details_screen.dart';
import '../../data/repository/fake_data.dart';

class DiscoverLocation extends BeamLocation {
  DiscoverLocation(BeamState state, this.rootContext) : super(state);
  final BuildContext rootContext;

  @override
  List<String> get pathBlueprints => ['/discover/:itemId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('discover'),
      title: 'Discover - Shodana Reader',
      type: BeamPageType.noTransition,
      child: DiscoverScreen(rootContext: rootContext),
    ),
    if (state.pathParameters.containsKey('itemId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['itemId']}'),
        child: InternetBookDetailsScreen(
          internetBook: internetBook,
          rootContext: rootContext
        ),
      ),
  ];
}