// APP
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'locations/home_location.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AppState();
}

final rootBeamerRouter = BeamerRouterDelegate(
    locationBuilder: (state) => HomeLocation(state));

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: rootBeamerRouter,
    );
  }
}
