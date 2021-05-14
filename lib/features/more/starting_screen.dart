

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/data/local/starting_screen_source.dart';
import 'package:shodana_reader/data/provider/starting_screen_provider.dart';
import 'package:shodana_reader/data/repository/starting_screen_repository.dart';

final appThemeNotifierProvider = ChangeNotifierProvider<AppStartingScreen>(
        (ref) => AppStartingScreen(ref.read(startingScreenRepositoryProvider)));

class AppStartingScreen extends ChangeNotifier {
  AppStartingScreen(this._repository);

  static const _defaultStartingScreen = BottomNavItems.home;

  final StartingScreenRepository _repository;

  BottomNavItems? _setting;

  BottomNavItems? get setting => _setting;

  Future<BottomNavItems?> startingScreen() async {
    if (setting == null) {
      _setting = await _repository.loadStartingScreen() ?? _defaultStartingScreen;
    }
    return setting;
  }

  Future<void> _loadHome() async {
    _setting = BottomNavItems.home;
    await _repository.saveStartingScreen(setting!).whenComplete(notifyListeners);
  }

  Future<void> _loadShelves() async {
    _setting = BottomNavItems.shelves;
    await _repository.saveStartingScreen(setting!).whenComplete(notifyListeners);
  }
}