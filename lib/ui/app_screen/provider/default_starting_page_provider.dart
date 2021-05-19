import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/local/storage_utils.dart';

final defaultStartingPageProvider =
StateNotifierProvider<DefaultStartingPage, int>((ref) {
  return DefaultStartingPage();
});

class DefaultStartingPage extends StateNotifier<int>{
  DefaultStartingPage() : super(StorageUtil.getInt('defaultStartingPage'));

  void setPage(int page) {
    state = page;
    StorageUtil.putInt('defaultStartingPage', page);
  }

  int getDefaultPage() {
    return state;
  }
}