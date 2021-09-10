import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/model/book_search_model.dart';
import '../../l10n/my.i18n.dart';
import '../widgets/search_bar.dart';

class ClubsScreenMobile extends HookConsumerWidget {
  const ClubsScreenMobile({
    Key? key, required this.beamToClub}) : super(key: key);
  final Function(BuildContext, String) beamToClub;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement search clubs and messages
    final BookSearchModel searchModel = ref.watch(bookSearchProvider);
    return Scaffold(
      // appBar: AppBar(title: 'Clubs'.i18n
      //     ?? 'No Title'.i18n)),
      body: SearchBar(
        body: buildClubs(context),
        hint: 'Search clubs...'.i18n,
        model: searchModel,
      ),
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
