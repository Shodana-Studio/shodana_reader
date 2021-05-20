import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/local/storage_utils.dart';
import 'default_starting_page_provider.dart';
import 'last_used_enabled_provider.dart';

final startingPageProvider =
StateNotifierProvider<StartingPage, String>((ref) {
  final defaultStartingPageProviderNotifier = ref.read
    (defaultStartingPageProvider.notifier);

  return StartingPage(
    defaultStartingPageProvider: defaultStartingPageProviderNotifier,
    lastUsedEnabled: ref.read(lastUsedEnabledProvider.notifier),
  );
});

class StartingPage extends StateNotifier<String>{
  StartingPage({
    required this.defaultStartingPageProvider,
    required this.lastUsedEnabled,
  }) : super(StorageUtil.getString('starting_screen', defValue: 'last_used'));
  final DefaultStartingPage defaultStartingPageProvider;
  final LastUsedEnabled lastUsedEnabled;

  void setScreen(String screen) {
    state = screen;
    StorageUtil.putString('starting_screen', screen);
    // 0: last_used
    // 1: home
    // 2: shelves
    // 3: clubs
    // // 4: discover
    // 4: more
    if (screen == 'last_used') {
      lastUsedEnabled.setEnabled();
    } else if (screen == 'home') {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(0);
    } else if (screen == 'shelves') {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(1);
    } else if (screen == 'clubs') {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(2);
    // } else if (screen == 'discover') {
    //   lastUsedEnabled.setDisabled();
    //   defaultStartingPageProvider.setPage(3);
    } else if (screen == 'more') {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(3); //.setPage(4)
    } else {
      debugPrint('Error: Invalid screen passed into setScreen');
    }
  }

  String getState() {
    return state;
  }
}