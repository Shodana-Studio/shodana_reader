import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';
import 'data/local/storage_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await StorageUtil.getInstance();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  if (savedThemeMode == AdaptiveThemeMode.dark) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0x00151414),
        systemNavigationBarDividerColor: Color(0x00151414),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Color(0x00151414),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  } else if (savedThemeMode == AdaptiveThemeMode.system) {
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
  runApp(ProviderScope(child: App(savedThemeMode: savedThemeMode)));
}
