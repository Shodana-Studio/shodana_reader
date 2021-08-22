import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/app_constants.dart';
import '../model/book.dart';

class StorageUtil {
  StorageUtil._();

  static StorageUtil? _storageUtil;
  static late final SharedPreferences _preferences;
  static late final Box _settingsBox;
  static late final Box _booksBox;

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
    _settingsBox = await Hive.openBox(AppConstant.settingsBoxKey);
    _booksBox = await Hive.openBox(AppConstant.booksBoxKey);
  }


  /// Get a dymanic variable from Hive 'settings' box.
  /// 
  /// Hive supports all primitive types, List, Map, DateTime, BigInt and Uint8List. Any object can be stored using TypeAdapters.
  static dynamic getSetting({required String key, required dynamic defValue}) {
    return _settingsBox.get(key) ?? defValue;
  }

  /// put a dynamic variable in Hive 'settings' box.
  /// 
  /// Hive supports all primitive types, List, Map, DateTime, BigInt and Uint8List. Any object can be stored using TypeAdapters.
  static Future<void> putSetting({required String key, required dynamic value}) {
    return _settingsBox.put(key, value);
  }

  /// clear Hive settings
  static Future<int> clrSettings() {
    final Box settings = _settingsBox;
    return settings.clear();
  }

  /// Get the books box
  static Box getBooksBox() {
    return Hive.box(AppConstant.booksBoxKey);
  }

  /// Get all books from Hive 'books' box.
  /// 
  /// Returns booksBox.values, of type Iterable<dynamic>
  static List<Book> getAllBooks() {
    return _booksBox.values.map((e) => e as Book).toList();
  }

  /// Get a book from Hive 'books' box.
  static Book? getBook({required int key, dynamic defValue}) {
    return _booksBox.get(key, defaultValue: defValue);
  }

  /// put a book in Hive 'books' box.
  static Future<int> addBook({required Book book}) {
    return _booksBox.add(book);
  }

  /// TODO: delete book from 'books' box



  /// get string from Shared Preferences
  static String getString(String key, {String defValue = ''}) {
    return _preferences.getString(key) ?? defValue;
  }

  /// put string in Shared Preferences
  static Future<bool> putString(String key, String value) {
    return _preferences.setString(key, value);
  }

  /// put bool in Shared Preferences
  static Future<bool> putBool(String key, {required bool value}) {
    return _preferences.setBool(key, value);
  }

  /// get bool from Shared Preferences
  static bool getBool(String key, {bool defValue = true}) {
    return _preferences.getBool(key) ?? defValue;
  }

  /// get int from Shared Preferences
  static int getInt(String key, {int defValue = 0}) {
    return _preferences.getInt(key) ?? defValue;
  }

  /// put bool in Shared Preferences
  static Future<bool> putInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  /// clear Shared Preferences
  static Future<bool> clrPrefs() {
    final SharedPreferences prefs = _preferences;
    return prefs.clear();
  }
}
