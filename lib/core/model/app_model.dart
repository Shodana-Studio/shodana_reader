import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/app_data.dart';

final appModelNotifierProvider = StateNotifierProvider<AppModelNotifier, AppData>((ref) {
  return AppModelNotifier();
});

class AppModelNotifier extends StateNotifier<AppData> {
  AppModelNotifier() : super(const AppData());
}
