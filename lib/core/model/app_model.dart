import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appModelProvider = Provider<AppModel>((ref) {
  final appModel = AppModel();

  return appModel;
});

class AppModel extends ChangeNotifier {
  String? _currentUser;
  String? get currentUser => _currentUser;
  set currentUser(String? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
  // Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}