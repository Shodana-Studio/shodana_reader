import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/local/storage_utils.dart';

final leftNavigationRailProvider =
StateNotifierProvider<LeftNavigationRail, bool>((ref) {
  return LeftNavigationRail();
});

class LeftNavigationRail extends StateNotifier<bool>{
  LeftNavigationRail() : super(StorageUtil.getBool('leftNavigationRail',
      defValue: false));

  void toggle() {
    state = !state;
    StorageUtil.putBool('leftNavigationRail', state);
  }

  bool getState() {
    return state;
  }
}
