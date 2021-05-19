import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/local/storage_utils.dart';
import 'nav_current_index_provider.dart';
// TODO: Convert to StateNotifierProvider to use SharedPreferences
final lastUsedEnabledProvider = StateProvider((ref) => true);
final lastUsedIndexProvider = StateProvider((ref) => ref.read(defaultStartingPageProvider));

final startingPageProvider =
StateNotifierProvider.family<StartingPage, String, BuildContext>((ref,
    context) {
  final defaultStartingPageProviderNotifier = ref.read
    (defaultStartingPageProvider.notifier);
  return StartingPage(
    defaultStartingPageProvider: defaultStartingPageProviderNotifier,
    context: context
  );
});

class StartingPage extends StateNotifier<String>{
  StartingPage({
    required this.context,
    required this.defaultStartingPageProvider}) :
        super(StorageUtil.getString('starting_screen',
          defValue: AppLocalizations.of(context)!.startingScreenOptionLastUsedText));
  final DefaultStartingPage defaultStartingPageProvider;
  final BuildContext context;

  void setScreen(String screen) {
    state = screen;
    StorageUtil.putString('starting_screen', screen);
      // 1: AppLocalizations.of(context)!.startingScreenOptionHomeText,
      // 2: AppLocalizations.of(context)!.startingScreenOptionShelvesText,
      // 3: AppLocalizations.of(context)!.startingScreenOptionClubsText,
      // // 4: AppLocalizations.of(context)!.startingScreenOptionDiscoverText,
      // 4: AppLocalizations.of(context)!.startingScreenOptionMoreText,
    if (screen == AppLocalizations.of(context)!
        .startingScreenOptionLastUsedText) {
      context.read(lastUsedEnabledProvider).state = true;
    } else if (screen == AppLocalizations.of(context)!
        .startingScreenOptionHomeText) {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(0);
    } else if (screen == AppLocalizations.of(context)!
        .startingScreenOptionShelvesText) {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(1);
    } else if (screen == AppLocalizations.of(context)!
        .startingScreenOptionClubsText) {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(2);
    // } else if (screen == AppLocalizations.of(context)!
    //     .startingScreenOptionDiscoverText) {
    //   context.read(lastUsedEnabledProvider).state = false;
    //   defaultStartingPageProvider.setPage(3);
    } else if (screen == AppLocalizations.of(context)!
        .startingScreenOptionMoreText) {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(3); //.setPage(4)
    } else {
      debugPrint('Error: Invalid screen passed into setScreen');
    }
  }

  String getState() {
    return state;
  }
}