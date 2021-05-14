// APP
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'locations/home_location.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  final rootBeamerRouter = BeamerRouterDelegate(
      locationBuilder: (state) => HomeLocation(state));

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: rootBeamerRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
