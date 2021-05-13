import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.morePageTitle
          ?? 'No Title')),
      body: Center(
        child: TextButton(
          onPressed: () {
            return context.beamToNamed('/more/0}');
          },
          child: const Text('Beam to More Option 0'),
        ),
      ),
    );
  }
}