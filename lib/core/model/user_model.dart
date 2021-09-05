import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/book.dart';

final userModelProvider = Provider<UserModel>((ref) {
  final userModel = UserModel();

  return userModel;
});

class UserModel extends ChangeNotifier {
  List<Book>? _userBooks;
  List<Book>? get userBooks => _userBooks;
  set userBooks(List<Book>? userBooks) {
    _userBooks = userBooks;
    notifyListeners();
  } 
  // In the future, this would contain other data about Users, maybe active friend lists, or notifications, etc
}