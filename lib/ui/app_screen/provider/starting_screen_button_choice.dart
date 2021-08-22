import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/data/service/storage_utils.dart';
import '../../../core/res/app_constants.dart';

final startingScreenButtonChoiceProvider =
StateNotifierProvider<StartingScreenButtonChoice, int>((ref) {
  return StartingScreenButtonChoice();
});

class StartingScreenButtonChoice extends StateNotifier<int>{
  // StartingScreenButtonChoice() : super(StorageUtil.getInt('startingScreenButtonChoice'));
  StartingScreenButtonChoice() : super(StorageUtil.getSetting(key: AppConstant.startingScreenButtonChoiceKey, defValue: 0));

  void setPage(int choice) {
    state = choice;
    // StorageUtil.putInt('startingScreenButtonChoice', choice);
    StorageUtil.putSetting(key: AppConstant.startingScreenButtonChoiceKey, value: choice);
  }

  int getChoice() {
    return state;
  }
}