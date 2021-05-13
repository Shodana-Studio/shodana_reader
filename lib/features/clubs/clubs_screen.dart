import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shodana_reader/core/providers/bottom_navigation_provider.dart';

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
            context.read(shouldShowBottomNavigationProvider).state = false;
            context.beamToNamed('/clubs/0}');
          },
          child: const Text('Beam to Test Club 0'),
        ),
      ),
    );
  }
}