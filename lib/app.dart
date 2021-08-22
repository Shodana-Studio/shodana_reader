// APP
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart' as appwrite;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/data/service/appwrite_service.dart';
import 'core/presentation/locations/app_location.dart';


class App extends StatefulWidget {
  const App({Key? key, this.savedThemeMode}) : super(key: key);
  final AdaptiveThemeMode? savedThemeMode;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final FlexScheme flexScheme = FlexScheme.blue;
  final rootBeamerRouter =
    // TODO: This breaks opening to a different tab than home by default. Need
    // to get from shared preferences instead of setting it to home by default.

    // kIsWeb ?
    // BeamerDelegate(
    //   initialPath: '/home',
    //   locationBuilder: SimpleLocationBuilder(
    //     routes: {
    //       '*': (context, state) => AppScreen(beamState: state,),
    //     },
    //   ),
    // );
    // :
    BeamerDelegate(
      locationBuilder: (state) => AppLocation(state),
    );

  

  @override
  Widget build(BuildContext context) {
    // Theming
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


    return appwrite.FlAppwriteAccountKit(
      client: AppwriteService.instance.client,
      child: AdaptiveTheme(
        light: light.copyWith(
          snackBarTheme: dark.snackBarTheme.copyWith(
            backgroundColor: Colors.grey[800],
            contentTextStyle: dark.textTheme.bodyText2
          ),
          bottomAppBarTheme: dark.bottomAppBarTheme.copyWith(
              color: Colors.white,
          ),
        ),
        dark: dark.copyWith(
          snackBarTheme: dark.snackBarTheme.copyWith(
            backgroundColor: Colors.grey[800],
            contentTextStyle: dark.textTheme.bodyText2
          ),
          bottomAppBarTheme: dark.bottomAppBarTheme.copyWith(
            color: Colors.grey[900],
          ),
        ),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) => MaterialApp.router(
          theme: theme,
          darkTheme: darkTheme,
          routeInformationParser: BeamerParser(),
          routerDelegate: rootBeamerRouter,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // supportedLocales: const [
          //    Locale('en', 'US'),
          // ],
          debugShowCheckedModeBanner: false,
          backButtonDispatcher: BeamerBackButtonDispatcher(
            delegate: rootBeamerRouter,
            // onBack: (defaultValue) => Future.value(true)
          ),
        ),
      ),
    );
  }
}
