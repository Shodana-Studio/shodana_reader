import 'package:flutter/material.dart';
import '../../../l10n/my.i18n.dart';

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
        title: Text('Reading: %s'.i18n.fill([chapter.first])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Chapter Contents: %s'.i18n.fill([chapter[1]])),
      ),
    );
  }
}