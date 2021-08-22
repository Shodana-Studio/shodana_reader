import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/service/storage_util.dart';
import '../../../core/res/app_constants.dart';

final lastUsedEnabledProvider =
StateNotifierProvider<LastUsedEnabled, bool>((ref) {
  return LastUsedEnabled();
});

class LastUsedEnabled extends StateNotifier<bool>{
  // LastUsedEnabled() : super(StorageUtil.getBool('lastUsedEnabled'));
  LastUsedEnabled() : super(StorageUtil.getSetting(key: AppConstant.lastUsedEnabledKey, defValue: true));


  void setEnabled() {
    state = true;
    // StorageUtil.putBool('lastUsedEnabled', value: true);
    StorageUtil.putSetting(key: AppConstant.lastUsedEnabledKey, value: true);
  }

  void setDisabled() {
    state = false;
    // StorageUtil.putBool('lastUsedEnabled', value: false);
    StorageUtil.putSetting(key: AppConstant.lastUsedEnabledKey, value: false);
  }

  bool getStatus() {
    return state;
  }
}