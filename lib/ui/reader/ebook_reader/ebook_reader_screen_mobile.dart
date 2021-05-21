import 'package:flutter/material.dart';

class EBookReaderScreenMobile extends StatelessWidget {
  const EBookReaderScreenMobile({
    Key? key,
    required this.chapter,
    required this.book,
  }) : super(key: key);

  final List<String> chapter;
  final Map<String, String> book;

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