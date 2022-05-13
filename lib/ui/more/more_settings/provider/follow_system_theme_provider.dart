import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app_constants.dart';
import '../../../../core/data/app_data.dart';
import '../../../../core/model/app_model.dart';
import '../../../../core/service/storage_util.dart';

final followSystemThemeSwitchProvider =
StateNotifierProvider<FollowSystemThemeSwitch, bool>((ref) {
  final appData = ref.read(appModelNotifierProvider);
  return FollowSystemThemeSwitch(appData, ref);
});

class FollowSystemThemeSwitch extends StateNotifier<bool>{
  FollowSystemThemeSwitch(AppData appData, this.ref) : super(appData.followSystemTheme);
  final ProviderRefBase ref;

  void toggle() {
    state = !state;
    StorageUtil.putSetting(key: AppConstant.followSystemThemeKey, value: state);
  }

  bool getState() {
    return state;
  }
}