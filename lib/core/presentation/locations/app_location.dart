import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import '../../../ui/app_screen/app_screen.dart';
class AppLocation extends BeamLocation {
  AppLocation(state) : super(state);
  @override
  List<String> get pathBlueprints => ['/*'];
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    // if (!state.pathParameters.containsValue('login'))
      BeamPage(
        key: ValueKey('app-${state.uri}'),
        child: I18n(child: AppScreen(beamState: state)),
      ),
    // if (state.pathParameters.containsValue('login'))
    //   BeamPage(
    //     key: ValueKey('app-${state.uri}'),
    //     child: LoginScreen(beamState: state),
    //   ),
  ];
}