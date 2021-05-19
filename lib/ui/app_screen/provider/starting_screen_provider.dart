import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/local/storage_utils.dart';
import 'default_starting_page_provider.dart';
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
    // 0: last_used
    // 1: home
    // 2: shelves
    // 3: clubs
    // // 4: discover
    // 4: more
    if (screen == 'last_used') {
      context.read(lastUsedEnabledProvider).state = true;
    } else if (screen == 'home') {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(0);
    } else if (screen == 'shelves') {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(1);
    } else if (screen == 'clubs') {
      context.read(lastUsedEnabledProvider).state = false;
      defaultStartingPageProvider.setPage(2);
    // } else if (screen == 'discover') {
    //   context.read(lastUsedEnabledProvider).state = false;
    //   defaultStartingPageProvider.setPage(3);
    } else if (screen == 'more') {
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