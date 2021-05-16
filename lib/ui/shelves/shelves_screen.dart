import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShelvesScreen extends StatelessWidget {
  const ShelvesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.shelvesPageTitle
          ?? 'No Title')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                return context.beamToNamed('/shelves/0}');
              },
              child: const Text('Beam to Test Shelf 0 Details'),
            ),
            TextButton(
              onPressed: () {
                return context.beamToNamed('/shelves/0/0}');
              },
              child: const Text('Beam to Test Book 0 Details'),
            ),
          ],
        ),
      ),
    );
  }
}