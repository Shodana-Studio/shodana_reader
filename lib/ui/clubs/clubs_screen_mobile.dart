import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClubsScreenMobile extends StatelessWidget {
  const ClubsScreenMobile({
    Key? key, required this.beamToClub,
  }) : super(key: key);
  final Function(BuildContext, String) beamToClub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.clubsPageTitle
          ?? 'No Title')),
      body: Center(
        child: TextButton(
          onPressed: () => beamToClub(context, '0'),
          child: const Text('Beam to Test Club 0'),
        ),
      ),
    );
  }
}