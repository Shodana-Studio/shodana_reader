// import 'dart:convert';

// import 'package:http/http.dart' as http;
import '../repository/fake_data.dart';

import 'book.dart';

abstract class SearchModel {
  bool isLoading = false;

  List<Book> suggestions = history;

  String query = '';

  Future<void> onQueryChanged(String query);

  void clear();
}