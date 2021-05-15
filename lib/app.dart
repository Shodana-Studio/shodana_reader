// APP
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'data/local/storage_utils.dart';
import 'data/provider/follow_system_theme_provider.dart';
import 'locations/home_location.dart';


class App extends HookWidget {
  App({Key? key}) : super(key: key);

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
