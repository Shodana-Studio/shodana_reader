import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/service/storage_utils.dart';
import '../../res/constants.dart';

final followSystemThemeSwitchProvider =
StateNotifierProvider<FollowSystemThemeSwitch, bool>((ref) {
  return FollowSystemThemeSwitch();
});

class FollowSystemThemeSwitch extends StateNotifier<bool>{
  // FollowSystemThemeSwitch() : super(StorageUtil.getBool('followSystemTheme'));
  FollowSystemThemeSwitch() : super(StorageUtil.getSetting(key: followSystemThemeKey, defValue: true));

  void toggle() {
    state = !state;
    // StorageUtil.putBool('followSystemTheme', value: state);
    StorageUtil.putSetting(key: followSystemThemeKey, value: state);
  }

  bool getState() {
    return state;
  }
}