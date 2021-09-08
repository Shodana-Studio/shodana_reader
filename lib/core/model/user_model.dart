import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/book.dart';
import '../data/user_data.dart';

final userModelProvider = StateNotifierProvider<UserModelNotifier, UserData>((ref) {
  const userData = UserData(
    books: [],
    shelves: []
  );

  return UserModelNotifier(userData);
});

class UserModelNotifier extends StateNotifier<UserData> {
  UserModelNotifier(UserData data) : super(data);

  // Put functions here using copyWith to change data

  // Update UserData with new list of books
  void setBooks(List<Book> books) {
    state = state.copyWith(books: books);
  }
}