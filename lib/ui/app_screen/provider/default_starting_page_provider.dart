import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/data/service/storage_utils.dart';
import '../../../core/res/constants.dart';

final defaultStartingPageProvider =
StateNotifierProvider<DefaultStartingPage, int>((ref) {
  return DefaultStartingPage();
});

class DefaultStartingPage extends StateNotifier<int>{
  // DefaultStartingPage() : super(StorageUtil.getInt('defaultStartingPage'));
  DefaultStartingPage() : super(StorageUtil.getSetting(key: AppConstant.defaultStartingPageKey, defValue: 0));

  void setPage(int page) {
    state = page;
    // StorageUtil.putInt('defaultStartingPage', page);
    StorageUtil.putSetting(key: AppConstant.defaultStartingPageKey, value: page);
  }

  int getDefaultPage() {
    return state;
  }
}