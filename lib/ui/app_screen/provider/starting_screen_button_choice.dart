import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/storage_utils.dart';

final startingScreenButtonChoiceProvider =
StateNotifierProvider<StartingScreenButtonChoice, int>((ref) {
  return StartingScreenButtonChoice();
});

class StartingScreenButtonChoice extends StateNotifier<int>{
  StartingScreenButtonChoice() : super(StorageUtil.getInt('startingScreenButtonChoice'));

  void setPage(int choice) {
    state = choice;
    StorageUtil.putInt('startingScreenButtonChoice', choice);
  }

  int getChoice() {
    return state;
  }
}