import 'package:flutter/material.dart';
import '../../../l10n/my.i18n.dart';

class ShelfDetailsScreenMobile extends StatelessWidget {
  const ShelfDetailsScreenMobile({
    Key? key,
    required this.beamToBook,
    required this.shelf,
    required this.rootContext
  }) : super(key: key);
  final Function(BuildContext, String, String) beamToBook;
  final Map<String, String> shelf;
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf['name']!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Author: %s'.i18n.fill([shelf['author']!])),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Books:'.i18n, style: const TextStyle(
                fontWeight: FontWeight.bold
            )),
          ),
          TextButton(
            onPressed: () => beamToBook(context, '0', '0'),
            child: const Text('Beam to Test Book 0 Details'),
          ),
        ],
      ),
    );
  }
}