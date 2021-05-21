import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'ebook_reader_screen_mobile.dart';

// TODO: Create reader for EPUB and other ebook files
class EBookReaderScreen extends StatelessWidget {
  const EBookReaderScreen({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);
  final Map<String, String> book;
  final List<String> chapter;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => EBookReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
      tablet: (BuildContext context) => EBookReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
      desktop: (BuildContext context) => EBookReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
      watch: (BuildContext context) => EBookReaderScreenMobile(
        chapter: chapter,
        book: book,
      ),
    );
  }
}