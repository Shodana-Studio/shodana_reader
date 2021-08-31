import 'dart:io' as io;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/book.dart';
import '../../app_constants.dart';

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

  static Future<io.Directory> getAppDirectory() async {
    io.Directory dir;
    if (io.Platform.isAndroid) {
      dir = (await getExternalStorageDirectory())!;
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    // Any OS
    // getApplicationDocumentsDirectory();

    // Use for cover images
    // getApplicationSupportDirectory();

    // No android support
    // getLibraryDirectory();

    // Android only
    // getExternalStorageDirectory();
    // getExternalStorageDirectories(type: StorageDirectory.documents);
    // getExternalCacheDirectories();

    return dir;
  }

  /// Copy the file on the device from file picker to the app director
  static Future<io.File> copyFile({required Uint8List bytes, required String folder, required String filename}) async {
    // Save files in directory accessible to the user on android
    final io.Directory dir = await getAppDirectory();

    // Get the reference to the file
    // final io.File fileRef = io.File(file.path!);
    // Create the folder
    await io.Directory('${dir.path}/ShodanaReader').create();
    await io.Directory('${dir.path}/ShodanaReader/$folder').create();
    // Copy the file to the app directory
    final io.File newFile = await io.File('${dir.path}/ShodanaReader/$folder/$filename').writeAsBytes(bytes);
    return newFile;
  }

  /// Get file from the user using FilePicker
  /// Retrieves the file(s) from the underlying platform
  ///
  /// Default `type` set to [FileType.any] with `allowMultiple` set to `false`.
  /// Optionally, `allowedExtensions` might be provided (e.g. `[pdf, svg, jpg]`.).
  ///
  /// If `withData` is set, picked files will have its byte data immediately available on memory as `Uint8List`
  /// which can be useful if you are picking it for server upload or similar. However, have in mind that
  /// enabling this on IO (iOS & Android) may result in out of memory issues if you allow multiple picks or
  /// pick huge files. Use `withReadStream` instead. Defaults to `true` on web, `false` otherwise.
  ///
  /// If `withReadStream` is set, picked files will have its byte data available as a `Stream<List<int>>`
  /// which can be useful for uploading and processing large files. Defaults to `false`.
  ///
  /// If you want to track picking status, for example, because some files may take some time to be
  /// cached (particularly those picked from cloud providers), you may want to set [onFileLoading] handler
  /// that will give you the current status of picking.
  ///
  /// If `allowCompression` is set, it will allow media to apply the default OS compression.
  /// Defaults to `true`.
  ///
  /// `dialogTitle` can be optionally set on desktop platforms to set the modal window title. It will be ignored on
  /// other platforms.
  ///
  /// The result is wrapped in a `FilePickerResult` which contains helper getters
  /// with useful information regarding the picked `List<PlatformFile>`.
  ///
  /// For more information, check the [API documentation](https://github.com/miguelpruivo/flutter_file_picker/wiki/api).
  static Future<List<PlatformFile>> fetchFile({String? dialogTitle,
    FileType type = FileType.any, List<String>? allowedExtensions,
    dynamic Function(FilePickerStatus)? onFileLoading, bool allowCompression = true,
    bool allowMultiple = false, bool withData = false, bool withReadStream = false
    }) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: dialogTitle,
      type: type,
      allowedExtensions: allowedExtensions,
      onFileLoading: onFileLoading,
      allowCompression: allowCompression,
      allowMultiple: allowMultiple,
      withData: withData,
      withReadStream: withReadStream,
    );

    if(result != null) {
      return result.files;
    } else {
      // User canceled the picker
      throw Exception('Failed to load book');
    }
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
  static Future<int> clearBooksBox() {
    return _booksBox.clear();
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
