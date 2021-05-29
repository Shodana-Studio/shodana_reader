import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/search_bar.dart';

class ShelvesScreenMobile extends StatelessWidget {
  const ShelvesScreenMobile({
    Key? key, required this.beamToShelf, required this.beamToBook,
  }) : super(key: key);
  final Function(BuildContext, String) beamToShelf;
  final Function(BuildContext, String, String) beamToBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)!.shelvesPageTitle)),
      body: SearchBar(body: buildShelves(context), hint: 'Search shelves...',),
    );
  }

  Widget buildShelves(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight + 8,),
            TextButton(
              onPressed: () => beamToShelf(context, '0'),
              child: const Text('Beam to Test Shelf 0 Details'),
            ),
            TextButton(
              onPressed: () => beamToBook(context, '0', '0'),
              child: const Text('Beam to Test Book 0 Details'),
            ),
            const SizedBox(height: 800,),
          ],
        ),
      ),
    );
  }
}