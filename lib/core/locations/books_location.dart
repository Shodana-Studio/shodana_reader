import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/screens/books/book_details_screen.dart';

import 'package:shodana_reader/screens/books/books_screen.dart';

class BooksLocation extends BeamLocation {
  BooksLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/books/:itemId'];

  Map<String, String> book = {'title': 'New Book', 'author': 'Best Author',
  'id': '0'};

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:
    BeamPage(
      key: const ValueKey('books'),
      child: const BooksScreen(),
    ),
    if (state.pathParameters.containsKey('bookId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['bookId']}'),
        child: BookDetailsScreen(
          book: book,
        ),
      ),
  ];
}