import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../l10n/my.i18n.dart';
import '../../discover/discover_screen.dart';
import '../../discover/internet_book_details/discover_details_screen.dart';
import '../../../core/data/repository/fake_data.dart';

class DiscoverLocation extends BeamLocation {
  DiscoverLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/discover/:itemId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('discover'),
      title: 'Discover - Shodana Reader'.i18n,
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