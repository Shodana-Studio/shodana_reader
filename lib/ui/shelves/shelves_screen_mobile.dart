import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/data/model/book_search_model.dart';
import '../widgets/search_bar.dart';

class ShelvesScreenMobile extends HookWidget {
  const ShelvesScreenMobile({
    Key? key, required this.beamToShelf, required this.beamToBook, required this.rootContext,
  }) : super(key: key);
  final Function(BuildContext, String) beamToShelf;
  final Function(BuildContext, String, String) beamToBook;
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement search clubs and messages
    final BookSearchModel searchModel = useProvider(bookSearchProvider);
    return Scaffold(
      // appBar: AppBar(title: Text(TR.of(context)!.shelvesPageTitle)),
      body: SearchBar(
        body: buildShelves(context),
        hint: 'Search shelves...',
        model: searchModel,
        rootContext: rootContext
      ),
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