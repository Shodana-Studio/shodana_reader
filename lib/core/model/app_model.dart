import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_constants.dart';
import '../data/app_data.dart';
import '../service/storage_util.dart';

final appModelNotifierProvider = StateNotifierProvider<AppModelNotifier, AppData>((ref) {
  final appData = AppData(
    darkMode: StorageUtil.getSetting(key: AppConstant.darkModeKey, defValue: true)
  );
  return AppModelNotifier(appData);
});

class AppModelNotifier extends StateNotifier<AppData> {
  AppModelNotifier(AppData appData) : super(appData);

  void toggleDarkMode() {
    final darkMode = state.darkMode;
    state.copyWith(darkMode: !darkMode);
    StorageUtil.putSetting(key: AppConstant.darkModeKey, value: !darkMode);
  }
}
