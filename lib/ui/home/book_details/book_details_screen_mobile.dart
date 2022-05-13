import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../l10n/my.i18n.dart';

class BookDetailsScreenMobile extends ConsumerWidget {
  const BookDetailsScreenMobile({
    Key? key,
    required this.book,
    required this.startReadingButtonPressed,
  }) : super(key: key);
  final Map<String, String> book;
  final Function(BuildContext, WidgetRef) startReadingButtonPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Author: %s'.i18n.fill([book['author']!])),
          ),
          TextButton(
            onPressed: () => startReadingButtonPressed(context, ref),
            child: Text('Start Reading'.i18n),
          ),
        ],
      ),
    );
  }
}
