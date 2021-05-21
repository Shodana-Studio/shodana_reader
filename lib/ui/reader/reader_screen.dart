import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/constants.dart';
import '../app_screen/provider/bottom_navigation_provider.dart';
import 'ebook_reader/ebook_reader_screen.dart';
import 'html_reader/html_reader_screen.dart';

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
          EBookReaderScreen(
            book: book,
            chapter: chapter
          ) :
          HTMLReaderScreen(
            book: book,
            chapter: chapter,
          ),
      ),
    );
  }
}