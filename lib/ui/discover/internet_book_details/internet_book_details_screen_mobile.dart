import 'package:flutter/material.dart';
import '../../../l10n/my.i18n.dart';

class InternetBookDetailsScreenMobile extends StatelessWidget {
  const InternetBookDetailsScreenMobile({
    Key? key,
    required this.internetBook,
  }) : super(key: key);

  final Map<String, String> internetBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(internetBook['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Author: %s'.i18n.fill([internetBook['author']!])),
      ),
    );
  }
}