// APP
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'data/local/storage_utils.dart';
import 'data/provider/follow_system_theme_provider.dart';
import 'locations/home_location.dart';


class App extends HookWidget {
  App({Key? key, this.savedThemeMode}) : super(key: key);
  final AdaptiveThemeMode? savedThemeMode;
  final rootBeamerRouter = BeamerRouterDelegate(
      locationBuilder: (state) => HomeLocation(state));

  // Used to store which FlexSchemeData option we selected
  FlexScheme flexScheme = FlexScheme.blue; // Default selected theme

  final light = ThemeData(
    appBarTheme: const AppBarTheme(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black, opacity: 0.87),
        textTheme: TextTheme(
          headline6: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0
    ),
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent,
  );

  final dark = ThemeData(
    appBarTheme: const AppBarTheme(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white, opacity: 0.87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0
    ),
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Colors.blue),
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: FlexColorScheme.light(
        appBarStyle: FlexAppBarStyle.background,
        scheme: flexScheme,
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,
      dark: FlexColorScheme.dark(
        scheme: flexScheme,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,
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
