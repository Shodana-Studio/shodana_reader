import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.discoverPageTitle
          ?? 'No Title')),
      body: Center(
        child: TextButton(
          onPressed: () {
            return context.beamToNamed('/discover/0}');
          },
          child: const Text('Beam to Test Internet Book 0 Details'),
        ),
      ),
    );
  }
}