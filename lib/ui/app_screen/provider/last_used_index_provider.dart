import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/storage_utils.dart';

final lastUsedIndexProvider =
StateNotifierProvider<LastUsedIndex, int>((ref) {
  return LastUsedIndex();
});

class LastUsedIndex extends StateNotifier<int>{
  LastUsedIndex() : super(StorageUtil.getInt('lastUsedInt'));

  void setPage(int page) {
    state = page;
    StorageUtil.putInt('lastUsedInt', page);
  }

  int getPage() {
    return state;
  }
}