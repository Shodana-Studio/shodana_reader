import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'html_reader_screen_mobile.dart';

// TODO: Create reader for html files
class HTMLReaderScreen extends StatelessWidget {
  const HTMLReaderScreen({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);
  final Map<String, String> book;
  final List<String> chapter;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => HTMLReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
      tablet: (BuildContext context) => HTMLReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
      desktop: (BuildContext context) => HTMLReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
      watch: (BuildContext context) => HTMLReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
    );
  }
}
