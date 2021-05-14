import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../data/repository/fake_data.dart';
import '../features/books/book_details_screen.dart';
import '../features/books/books_screen.dart';
import '../features/reader/reader_screen.dart';

class BooksLocation extends BeamLocation {
  BooksLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/books/:bookId/:chapterId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
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

    if (state.pathParameters.containsKey('chapterId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['bookId']}-chapter-${state
            .pathParameters['chapterId']}'),
        child: ReaderScreen(
          book: book,
          chapter: chapter,
        ),
      ),
  ];
}