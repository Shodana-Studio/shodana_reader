import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/model/book_search_model.dart';
import '../../l10n/my.i18n.dart';
import '../widgets/search_bar.dart';

class DiscoverScreenMobile extends HookConsumerWidget {
  const DiscoverScreenMobile({
    Key? key, required this.beamToInternetBook
  }) : super(key: key);
  final Function(BuildContext, String) beamToInternetBook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement search public clubs
    final BookSearchModel searchModel = ref.watch(bookSearchProvider);
    return Scaffold(
      // appBar: AppBar(title: Text(TR.of(context)!.discoverPageTitle)),
      body: SearchBar(
        body: buildDiscover(context),
        hint: 'Search online...'.i18n,
        model: searchModel,
      ),
    );
  }

  Widget buildDiscover(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight + 8,),
            TextButton(
              onPressed: () => beamToInternetBook(context, '0'),
              child: const Text('Beam to Test Internet Book 0 Details'),
            ),
            const SizedBox(height: 800,),
          ],
        ),
      ),
    );
  }
}