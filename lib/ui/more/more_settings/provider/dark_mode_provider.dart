import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/res/app_constants.dart';
import '../../../../core/service/storage_util.dart';

final darkModeSwitchProvider =
StateNotifierProvider<DarkModeSwitch, bool>((ref) {
  return DarkModeSwitch();
});

class DarkModeSwitch extends StateNotifier<bool>{
  // DarkModeSwitch() : super(StorageUtil.getBool('darkMode'));
  DarkModeSwitch() : super(StorageUtil.getSetting(key: AppConstant.darkModeKey, defValue: true));

  void toggle() {
    state = !state;
    // StorageUtil.putBool('darkMode', value: state);
    StorageUtil.putSetting(key: AppConstant.darkModeKey, value: state);
  }

  bool getState() {
    return state;
  }
}