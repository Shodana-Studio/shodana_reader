import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/screens/app_screen.dart';

class HomeLocation extends BeamLocation {
  HomeLocation(state) : super(state);

  @override
  List<String> get pathBlueprints => ['/*'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: ValueKey('app-${state.uri}'),
      child: AppScreen(beamState: state),
    ),
  ];
}
