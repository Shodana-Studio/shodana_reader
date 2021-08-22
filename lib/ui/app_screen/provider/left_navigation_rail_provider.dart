import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/service/storage_util.dart';
import '../../../core/res/app_constants.dart';

final leftNavigationRailProvider =
StateNotifierProvider<LeftNavigationRail, bool>((ref) {
  return LeftNavigationRail();
});

class LeftNavigationRail extends StateNotifier<bool>{
  // LeftNavigationRail() : super(StorageUtil.getBool('leftNavigationRail', defValue: false));
  LeftNavigationRail() : super(StorageUtil.getSetting(key: AppConstant.leftNavigationRailKey, defValue: false));

  void toggle() {
    state = !state;
    // StorageUtil.putBool('leftNavigationRail', value: state);
    StorageUtil.putSetting(key: AppConstant.leftNavigationRailKey, value: state);
  }

  bool getState() {
    return state;
  }
}
