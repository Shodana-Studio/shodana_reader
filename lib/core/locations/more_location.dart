import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/core/data/fake_data.dart';
import 'package:shodana_reader/features/more/more_details_screen.dart';
import 'package:shodana_reader/features/more/more_screen.dart';

class MoreLocation extends BeamLocation {
  MoreLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/more/:itemId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('more'),
      child: const MoreScreen(),
    ),
    if (state.pathParameters.containsKey('itemId'))
      BeamPage(
        key: ValueKey('more-${state.pathParameters['itemId']}'),
        child: MoreDetailsScreen(
          option: option,
        ),
      ),
  ];
}