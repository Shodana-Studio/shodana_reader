import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../more/more_details_screen.dart';

class MoreLocation extends BeamLocation {
  MoreLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/more/:itemId/:item2Id'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    // More screen removed. Could return in another form for certain devices
    // BeamPage(
    //   key: const ValueKey('more'),
    //   title: 'More - Shodana Reader'.i18n,
    //   type: BeamPageType.noTransition,
    //   child: const MoreScreen(),
    // ),
    if (state.pathParameters.containsKey('itemId'))
      BeamPage(
        key: ValueKey('more-${state.pathParameters['itemId']}'),
        child: MoreDetailsScreen(
          option: state.pathParameters['itemId'] ?? '',
        ),
      ),
    if (state.pathParameters.containsKey('item2Id'))
      BeamPage(
        key: ValueKey('more-itemId-${state
            .pathParameters['itemId']}-item2Id-${state
            .pathParameters['item2Id']}'),
        child: MoreDetailsScreen(
          option: state.pathParameters['item2Id'] ?? '',
        ),
      ),
  ];
}