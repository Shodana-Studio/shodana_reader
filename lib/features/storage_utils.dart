import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  StorageUtil._();

  static StorageUtil? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageUtil?> getInstance() async {
    if (_storageUtil == null) {
      final secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) {
      return defValue;
    }
    return _preferences!.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) {
    if (_preferences == null) {
      return Future.value(null);
    }
    return _preferences!.setString(key, value);
  }

  // clear string
  static Future<bool> clrPrefs() {
    final SharedPreferences prefs = _preferences!;
    return prefs.clear();
  }

  // put bool
  // ignore: avoid_positional_boolean_parameters
  static Future<bool> putBool(String key, bool value) {
    if (_preferences == null) {
      return Future.value(null);
    }
    return _preferences!.setBool(key, value);
  }

  // get string
  static bool getBool(String key, {bool defValue = true}) {
    if (_preferences == null) {
      return defValue;
    }
    return _preferences!.getBool(key) ?? defValue;
  }
}
