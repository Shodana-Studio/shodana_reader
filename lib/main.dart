import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';
import 'data/local/storage_utils.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  await StorageUtil.getInstance();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(child: App(savedThemeMode: savedThemeMode)));
}
