import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../data/repository/fake_data.dart';
import '../ui/books/book_details_screen.dart';
import '../ui/reader/reader_screen.dart';
import '../ui/shelves/shelf_details_screen.dart';
import '../ui/shelves/shelves_screen.dart';

class ShelvesLocation extends BeamLocation {
  ShelvesLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/shelves/:shelfId/:bookId/:chapterId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('shelves'),
      child: const ShelvesScreen(),
    ),

    if (state.pathParameters.containsKey('shelfId'))
      BeamPage(
        key: ValueKey('shelf-${state.pathParameters['shelfId']}'),
        child: ShelfDetailsScreen(
          shelf: shelf,
        ),
      ),

    if (state.pathParameters.containsKey('bookId'))
      BeamPage(
        key: ValueKey('shelf-${state.pathParameters['bookId']}-book-${state
            .pathParameters['bookId']}'),
        child: BookDetailsScreen(
          book: book,
        ),
      ),

    if (state.pathParameters.containsKey('chapterId'))
      BeamPage(
        key: ValueKey('shelf-${state.pathParameters['shelfId']}-book-${state
          .pathParameters['bookId']}-chapter-${state
          .pathParameters['chapterId']}'),
        child: ReaderScreen(
          book: book,
          chapter: chapter,
        ),
      ),
  ];
}