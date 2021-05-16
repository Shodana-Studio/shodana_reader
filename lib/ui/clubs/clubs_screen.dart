import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.clubsPageTitle
          ?? 'No Title')),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.beamToNamed('/clubs/0}');
          },
          child: const Text('Beam to Test Club 0'),
        ),
      ),
    );
  }
}