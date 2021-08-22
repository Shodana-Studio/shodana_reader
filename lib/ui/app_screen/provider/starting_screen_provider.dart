import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/service/storage_util.dart';
import '../../../core/res/app_constants.dart';
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
  // StartingPage({
  //   required this.defaultStartingPageProvider,
  //   required this.lastUsedEnabled,
  // }) : super(StorageUtil.getString('starting_screen', defValue: 'last_used'));
  StartingPage({
    required this.defaultStartingPageProvider,
    required this.lastUsedEnabled,
  }) : super(StorageUtil.getSetting(key: AppConstant.startingScreenKey, defValue: AppConstant.lastUsedScreen));
  final DefaultStartingPage defaultStartingPageProvider;
  final LastUsedEnabled lastUsedEnabled;

  void setScreen(String screen) {
    state = screen;
    // StorageUtil.putString('starting_screen', screen);
    StorageUtil.putSetting(key: AppConstant.startingScreenKey, value: screen);
    
    // 0: lastUsedScreen
    // 1: homeScreen
    // 2: shelvesScreen
    // 3: clubsScreen
    // 4: discoverScreen
    // // 5: moreScreen
    if (screen == AppConstant.lastUsedScreen) {
      lastUsedEnabled.setEnabled();
    } else if (screen == AppConstant.homeScreen) {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(0);
    } else if (screen == AppConstant.shelvesScreen) {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(1);
    } else if (screen == AppConstant.clubsScreen) {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(2);
    } else if (screen == AppConstant.discoverScreen) {
      lastUsedEnabled.setDisabled();
      defaultStartingPageProvider.setPage(3);
    // } else if (screen == moreScreen) {
    //   lastUsedEnabled.setDisabled();
    //   defaultStartingPageProvider.setPage(4);
    } else {
      debugPrint('Error: Invalid screen passed into setScreen');
    }
  }

  String getState() {
    return state;
  }
}