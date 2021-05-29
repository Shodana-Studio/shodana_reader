import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_floating_search_bar/material_floating_search_bar'
    '.dart';

class ClubsScreenMobile extends StatelessWidget {
  const ClubsScreenMobile({
    Key? key, required this.beamToClub,
  }) : super(key: key);
  final Function(BuildContext, String) beamToClub;
// Center(
  //   child: TextButton(
  //     onPressed: () => beamToClub(context, '0'),
  //     child: const Text('Beam to Test Club 0'),
  //   ),
  // ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)?.clubsPageTitle
      //     ?? 'No Title')),
      body: buildFloatingSearchBar(context),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search Clubs',
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      // automaticallyImplyBackButton: true,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 80),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      // debounceDelay: const Duration(milliseconds: 300),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      // transition: ExpandingFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction(
          builder: (context, animation) {
            final bar = FloatingSearchAppBar.of(context)!;

            return ValueListenableBuilder<String>(
              valueListenable: bar.queryNotifer,
              builder: (context, query, _) {
                final isEmpty = query.isEmpty;

                return SearchToClear(
                  isEmpty: isEmpty,
                  color: bar.style.iconColor,
                  duration: const Duration(milliseconds: 900) * 0.5,
                  onTap: () {
                    if (!isEmpty) {
                      bar.clear();
                    } else {
                      bar.isOpen =
                          !bar.isOpen || (!bar.hasFocus && bar.isAlwaysOpened);
                    }
                  },
                );
              },
            );
          },
        ),
        FloatingSearchBarAction.back(),
      ],
      actions: [
        FloatingSearchBarAction(
          child: CircularButton(
            icon: const CircleAvatar(
              radius: 16.0,
              child: Text('A'),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Shodana'),
                    content: Text('email'),
                  );
                },
              );
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Theme.of(context).snackBarTheme.backgroundColor,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('white', style: Theme.of(context).textTheme.bodyText1,),
                  leading: const Icon(Icons.history),
                ),
                ListTile(
                  title: Text("Didn't I say to make my abilities "
                    'average in the next life?!',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: const Icon(Icons.history),
                ),
              ],
            ),
          ),
        );
      },
      body: buildClubs(context),
    );
  }

  Widget buildClubs(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight,),
            ListTile(
              title: const Text('Beam to Test Club 0'),
              subtitle: const Text('Best club there is'),
              onTap: () => beamToClub(context, '0'),
            ),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
            ListTile(
              title: const Text('Beam to Test Club 0'),
              subtitle: const Text('Best club there is'),
              onTap: () => beamToClub(context, '0'),
            ),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}