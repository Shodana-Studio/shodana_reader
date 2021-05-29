import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/search_bar.dart';

class ClubsScreenMobile extends StatelessWidget {
  const ClubsScreenMobile({
    Key? key, required this.beamToClub,
  }) : super(key: key);
  final Function(BuildContext, String) beamToClub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)?.clubsPageTitle
      //     ?? 'No Title')),
      body: SearchBar(body: buildClubs(context), hint: 'Search clubs...',),
    );
  }

  Widget buildClubs(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight + 8,),
            ListTile(
              title: const Text('Beam to Test Club 0'),
              subtitle: const Text('Best club there is'),
              onTap: () => beamToClub(context, '0'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12,),
            ),
            ListTile(
              title: const Text('Beam to Test Club 0'),
              subtitle: const Text('Best club there is'),
              onTap: () => beamToClub(context, '0'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12,),
            ),
            const SizedBox(height: 800,),
          ],
        ),
      ),
    );
  }
}
