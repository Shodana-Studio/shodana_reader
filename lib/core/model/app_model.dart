import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/core/data/app_data.dart';

final appModelProvider = StateProvider<AppModel>((ref) => AppModel());

final appModelNotifierProvider = StateNotifierProvider<AppModelNotifier, AppData>((ref) {
  return AppModelNotifier();
});
class AppModelNotifier extends StateNotifier<AppData> {
  AppModelNotifier() : super(const AppData());
  
}



class AppModel extends ChangeNotifier {
  String? _currentUser;
  String? get currentUser => _currentUser;
  set currentUser(String? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
  // Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}