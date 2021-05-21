import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShelvesScreenMobile extends StatelessWidget {
  const ShelvesScreenMobile({
    Key? key, required this.beamToShelf, required this.beamToBook,
  }) : super(key: key);
  final Function(BuildContext, String) beamToShelf;
  final Function(BuildContext, String, String) beamToBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.shelvesPageTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => beamToShelf(context, '0'),
              child: const Text('Beam to Test Shelf 0 Details'),
            ),
            TextButton(
              onPressed: () => beamToBook(context, '0', '0'),
              child: const Text('Beam to Test Book 0 Details'),
            ),
          ],
        ),
      ),
    );
  }
}