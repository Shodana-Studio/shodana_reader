import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/res/app_constants.dart';
import '../../../../core/service/storage_util.dart';

final followSystemThemeSwitchProvider =
StateNotifierProvider<FollowSystemThemeSwitch, bool>((ref) {
  return FollowSystemThemeSwitch();
});

class FollowSystemThemeSwitch extends StateNotifier<bool>{
  // FollowSystemThemeSwitch() : super(StorageUtil.getBool('followSystemTheme'));
  FollowSystemThemeSwitch() : super(StorageUtil.getSetting(key: AppConstant.followSystemThemeKey, defValue: true));

  void toggle() {
    state = !state;
    // StorageUtil.putBool('followSystemTheme', value: state);
    StorageUtil.putSetting(key: AppConstant.followSystemThemeKey, value: state);
  }

  bool getState() {
    return state;
  }
}