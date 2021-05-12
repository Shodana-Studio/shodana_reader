import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../screens/books/books_screen.dart';

class BooksLocation extends BeamLocation {
  BooksLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/books/:itemId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:

    BeamPage(
      key: const ValueKey('books'),
      child: const BooksScreen(),
    ),
    // if (state.pathParameters.containsKey('bookId'))
    //   BeamPage(
    //     key: ValueKey('book-${state.pathParameters['bookId']}'),
    //     child: BookDetailsScreen(
    //       bookId: state.pathParameters['bookId'],
    //     ),
    //   ),
  ];
}