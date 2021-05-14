import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  SharedPreferences? _prefs;

  Future<SharedPreferences?> getInstance() async {
    // ignore: join_return_with_assignment
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }
}