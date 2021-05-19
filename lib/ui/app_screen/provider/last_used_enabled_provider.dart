import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/local/storage_utils.dart';

final lastUsedEnabledProvider =
StateNotifierProvider<LastUsedEnabled, bool>((ref) {
  return LastUsedEnabled();
});

class LastUsedEnabled extends StateNotifier<bool>{
  LastUsedEnabled() : super(StorageUtil.getBool('lastUsedEnabled'));

  void setEnabled() {
    state = true;
    StorageUtil.putBool('lastUsedEnabled', true);
  }

  void setDisabled() {
    state = false;
    StorageUtil.putBool('lastUsedEnabled', false);
  }

  bool getStatus() {
    return state;
  }
}