// APP
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'locations/app_location.dart';


class App extends HookWidget {
  App({Key? key, this.savedThemeMode}) : super(key: key);
  final AdaptiveThemeMode? savedThemeMode;
  final rootBeamerRouter = BeamerRouterDelegate(
      locationBuilder: (state) => AppLocation(state));

  // Used to store which FlexSchemeData option we selected
  final FlexScheme flexScheme = FlexScheme.blue; // Default selected theme

  @override
  Widget build(BuildContext context) {
    final light = FlexColorScheme.light(
      appBarStyle: FlexAppBarStyle.background,
      scheme: flexScheme,
      // Use comfortable on desktops instead of compact, devices use default.
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    ).toTheme;
    final dark = FlexColorScheme.dark(
      scheme: flexScheme,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    ).toTheme;


    return AdaptiveTheme(
      light: light,
      dark: dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => GetMaterialApp.router(
        theme: theme,
        darkTheme: darkTheme,
        routeInformationParser: BeamerRouteInformationParser(),
        routerDelegate: rootBeamerRouter,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
