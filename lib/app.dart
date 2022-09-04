// APP
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:appwrite_auth_kit/appwrite_auth_kit.dart';
import 'package:beamer/beamer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/commands/base_command.dart' as commands;
import 'ui/app_screen/locations/app_location.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key, this.savedThemeMode}) : super(key: key);
  final AdaptiveThemeMode? savedThemeMode;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final FlexScheme flexScheme = FlexScheme.blue;
  final rootBeamerRouter =
      // TODO(@getBoolean): This breaks opening to a different tab than home by default. Need
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
    locationBuilder: AppLocation.new,
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
    final baseCommand = ref.watch(commands.baseCommandProvider);
    return AppwriteAuthKit(
      client: baseCommand.appwriteService.client,
      child: AdaptiveTheme(
        light: light.copyWith(
          snackBarTheme: dark.snackBarTheme.copyWith(
              backgroundColor: Colors.grey[800],
              contentTextStyle: dark.textTheme.bodyText2),
          bottomAppBarTheme: dark.bottomAppBarTheme.copyWith(
            color: Colors.white,
          ),
        ),
        dark: dark.copyWith(
          snackBarTheme: dark.snackBarTheme.copyWith(
              backgroundColor: Colors.grey[800],
              contentTextStyle: dark.textTheme.bodyText2),
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
