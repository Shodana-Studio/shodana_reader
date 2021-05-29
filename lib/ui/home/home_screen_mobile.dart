import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/search_bar.dart';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({
    Key? key,
    required this.fabOnPressed,
    required this.bookOnPressed,
  }) : super(key: key);
  final VoidCallback fabOnPressed;
  final VoidCallback bookOnPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: SearchBar(body: buildHome(context), hint: 'Search recents...',),
      floatingActionButton: FloatingActionButton(
        onPressed: fabOnPressed,
        tooltip: 'Add an eBook',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildHome(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: kToolbarHeight + 8,),
          TextButton(
            onPressed: bookOnPressed,
            child: const Text('Beam to Test Book 0 Details'),
          ),
        ],
      ),
    );
  }
}
