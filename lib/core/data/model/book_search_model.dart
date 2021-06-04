import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/fake_data.dart';
import 'book.dart';
import 'search_model.dart';

final bookSearchProvider =
    ChangeNotifierProvider<BookSearchModel>(
        (ref) => BookSearchModel());

class BookSearchModel extends ChangeNotifier implements SearchModel {
  @override
  Future<void> onQueryChanged(String query) async {
    if (query == this.query) {
      return;
    }

    this.query = query;
    isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      suggestions = history;
    } else {
      // TODO: Search database of books and set _suggestions

      // final response = await http.get(Uri(path: 'https://photon.komoot.io/api/?q=$query'));
      // final body = json.decode(utf8.decode(response.bodyBytes));
      // final features = body['features'] as List;
      
      // Fake database of books
      suggestions = books.where((book) {
        print(book.toString());
        return book.toString().toLowerCase().contains(query.toLowerCase());
      }).toSet().toList();
      // _suggestions = features.map((e) => BookModel.fromJson(e)).toSet().toList();
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  bool isLoading = false;

  @override
  String query = '';

  @override
  List<Book> suggestions = history;

  @override
  void clear() {
    suggestions = history;
    notifyListeners();
  }
}