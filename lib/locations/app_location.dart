import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../ui/app_screen/app_screen.dart';

class AppLocation extends BeamLocation {
  AppLocation(state) : super(state);

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
