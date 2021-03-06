import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/service/storage_utils.dart';
import '../../../core/res/constants.dart';

final lastUsedIndexProvider =
StateNotifierProvider<LastUsedIndex, int>((ref) {
  return LastUsedIndex();
});

class LastUsedIndex extends StateNotifier<int>{
  // LastUsedIndex() : super(StorageUtil.getInt('lastUsedInt'));
  LastUsedIndex() : super(StorageUtil.getSetting(key: AppConstant.lastUsedIntKey, defValue: 0));

  void setPage(int page) {
    state = page;
    // StorageUtil.putInt('lastUsedInt', page);
    StorageUtil.putSetting(key: AppConstant.lastUsedIntKey, value: page);
  }

  int getPage() {
    return state;
  }
}