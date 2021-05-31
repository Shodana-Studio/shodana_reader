// APP
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/presentation/locations/app_location.dart';


class App extends StatefulWidget {
  const App({Key? key, this.savedThemeMode}) : super(key: key);
  final AdaptiveThemeMode? savedThemeMode;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late Client client;
  final FlexScheme flexScheme = FlexScheme.blue;
  final rootBeamerRouter =
    // TODO: This breaks opening to a different tab than home by default. Need
    // to get from shared preferences instead of setting it to home by default.

    // kIsWeb ?
    // BeamerDelegate(
    //   initialPath: '/home',
    //   locationBuilder: SimpleLocationBuilder(
    //     routes: {
    //       '/*': (context) => AppScreen(beamState: Beamer.of(context).state),
    //     },
    //   ),
    // ) :
    BeamerDelegate(
      locationBuilder: (state) => AppLocation(state),
    );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Client();
    client
        .setEndpoint('http://192.168.1.204/v1')
        .setProject('60a984c918aa7')
        .setSelfSigned() // TODO: Remove in production
        ;
  }

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


    return FlAppwriteAccountKit(
      client: client,
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
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
