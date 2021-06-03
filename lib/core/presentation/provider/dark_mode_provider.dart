import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/service/storage_utils.dart';
import '../../res/constants.dart';

final darkModeSwitchProvider =
StateNotifierProvider<DarkModeSwitch, bool>((ref) {
  return DarkModeSwitch();
});

class DarkModeSwitch extends StateNotifier<bool>{
  // DarkModeSwitch() : super(StorageUtil.getBool('darkMode'));
  DarkModeSwitch() : super(StorageUtil.getSetting(key: darkModeKey, defValue: true));

  void toggle() {
    state = !state;
    // StorageUtil.putBool('darkMode', value: state);
    StorageUtil.putSetting(key: darkModeKey, value: state);
  }

  bool getState() {
    return state;
  }
}