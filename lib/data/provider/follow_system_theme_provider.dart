import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/local/storage_utils.dart';

final followSystemThemeSwitchProvider =
StateNotifierProvider<FollowSystemThemeSwitch, bool>((ref) {
  return FollowSystemThemeSwitch();
});

class FollowSystemThemeSwitch extends StateNotifier<bool>{
  FollowSystemThemeSwitch() : super(StorageUtil.getBool('followSystemTheme'));

  void toggle() {
    state = !state;
    StorageUtil.putBool('followSystemTheme', value: state);
  }

  bool getState() {
    return state;
  }
}