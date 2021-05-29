import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/search_bar.dart';

class DiscoverScreenMobile extends StatelessWidget {
  const DiscoverScreenMobile({
    Key? key, required this.beamToInternetBook,
  }) : super(key: key);
  final Function(BuildContext, String) beamToInternetBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)!.discoverPageTitle)),
      body: SearchBar(body: buildDiscover(context), hint: 'Search online...',),
    );
  }

  Center buildDiscover(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kToolbarHeight + 8,),
          TextButton(
            onPressed: () => beamToInternetBook(context, '0'),
            child: const Text('Beam to Test Internet Book 0 Details'),
          ),
        ],
      ),
    );
  }
}