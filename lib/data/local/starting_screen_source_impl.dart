import 'package:enum_to_string/enum_to_string.dart';

import 'app_shared_preferences.dart';
import 'starting_screen_source.dart';

class StartingScreenSourceImpl extends StartingScreenSource {
  StartingScreenSourceImpl(this._prefs);

  static const String keyStartingScreen = 'home';

  final AppSharedPreferences _prefs;

  @override
  Future<BottomNavItems?> loadStartingScreen() async {
    final prefs = await _prefs.getInstance();
    return EnumToString.fromString(
        BottomNavItems.values, prefs!.getString(keyStartingScreen)!);
  }

  @override
  Future<bool> saveStartingScreen(BottomNavItems screen) async {
    final prefs = await _prefs.getInstance();
    return prefs!.setString(
        keyStartingScreen, EnumToString.convertToString(screen));
  }
}