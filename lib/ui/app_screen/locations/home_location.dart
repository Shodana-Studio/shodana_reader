import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../core/repository/fake_data.dart';
import '../../../app_constants.dart';
import '../../../l10n/my.i18n.dart';
import '../../home/book_details/book_details_screen.dart';
import '../../home/home_screen.dart';
import '../../reader/reader_screen.dart';

/// The home tab will contain recent books, books that haven't been started,
/// reading stats, and reading goals.
class HomeLocation extends BeamLocation {
  HomeLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/home/:bookId/:chapterId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('home'),
      title: 'Shodana Reader Home'.i18n,
      type: BeamPageType.noTransition,
      child: const HomeScreen(),
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
        key: ValueKey('home-${state.pathParameters['bookId']}-chapter-${state
            .pathParameters['chapterId']}'),
        child: ReaderScreen(
          book: book,
          chapter: chapter,
          bookFileType: BookFileType.epub,
        ),
      ),
  ];
}