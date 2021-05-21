import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/constants.dart';
import '../app_screen/provider/bottom_navigation_provider.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({
    Key? key,
    required this.book,
    required this.chapter,
    required this.bookFileType,
  }) : super(key: key);
  final BookFileType bookFileType;
  final Map<String, String> book;
  final List<String> chapter;
  // Handle each type of book differently
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () async {
        context.read(shouldShowBottomNavigationProvider).state = true;
        await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: bookFileType == BookFileType.epub ?
          EBookReader(
            book: book,
            chapter: chapter
          ) :
          HTMLReader(
            book: book,
            chapter: chapter,
          ),
      ),
    );
  }
}

// TODO: Create reader for EPUB and other ebook files
class EBookReader extends StatelessWidget {
  const EBookReader({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);
  final Map<String, String> book;
  final List<String> chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading: ${chapter.first}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Chapter Contents: ${chapter[1]}'),
      ),
    );
  }
}


// TODO: Create reader for html files
class HTMLReader extends StatelessWidget {
  const HTMLReader({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);
  final Map<String, String> book;
  final List<String> chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading: ${chapter.first}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Chapter Contents: ${chapter[1]}'),
      ),
    );
  }
}
