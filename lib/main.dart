import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app.dart';
import 'core/data/book.dart';
import 'core/data/book_type.dart';
import 'core/data/shelf.dart';
import 'core/service/storage_util.dart';

Future<AdaptiveThemeMode?> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get rid of # in url
  Beamer.setPathUrlStrategy();

  EquatableConfig.stringify = true;

  // Hive setup
  await Hive.initFlutter('hive_database');
  Hive.registerAdapter(BookTypeAdapter());
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(ShelfAdapter());

  await StorageUtil.getInstance();
  // Uncomment to clear previous books database. Book files and images must be deleted manually
  // await StorageUtil.clearBooksBox();
  // Themes
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

  return savedThemeMode;
}

Future<void> main() async {
  final savedThemeMode = await init();
  runApp(ProviderScope(child: App(savedThemeMode: savedThemeMode)));
}
