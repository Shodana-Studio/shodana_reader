import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:beamer/beamer.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.appName
          ?? 'No Title')),
      body: Center(
        child: TextButton(
          onPressed: () => context.beamToNamed('/books/0}'),
          child: const Text('Beam to Books'),
        ),
      ),
    );
  }
}