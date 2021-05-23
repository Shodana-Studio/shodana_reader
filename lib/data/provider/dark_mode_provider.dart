import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../storage_utils.dart';

final darkModeSwitchProvider =
StateNotifierProvider<DarkModeSwitch, bool>((ref) {
  return DarkModeSwitch();
});

class DarkModeSwitch extends StateNotifier<bool>{
  DarkModeSwitch() : super(StorageUtil.getBool('darkMode'));

  void toggle() {
    state = !state;
    StorageUtil.putBool('darkMode', value: state);
  }

  bool getState() {
    return state;
  }
}