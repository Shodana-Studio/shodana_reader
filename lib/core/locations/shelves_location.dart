import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shodana_reader/core/data/fake_data.dart';
import 'package:shodana_reader/features/books/book_details_screen.dart';
import 'package:shodana_reader/features/shelves/shelf_details_screen.dart';
import 'package:shodana_reader/features/shelves/shelves_screen.dart';

class ShelvesLocation extends BeamLocation {
  ShelvesLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/shelves/:shelfId/:bookId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    // TODO:

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
        key: ValueKey('shelf-book-${state.pathParameters['bookId']}'),
        child: BookDetailsScreen(
          book: book,
        ),
      ),
  ];
}