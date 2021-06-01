import 'package:cached_network_image/cached_network_image.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shodana_reader/ui/more/more_about/more_about_screen.dart';
import 'package:shodana_reader/ui/more/more_settings/more_settings_screen.dart';

import '../app_screen/provider/bottom_navigation_provider.dart';
import '../more/more_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.body,
    this.hint='Search...'
  }) : super(key: key);

  final Widget? body;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return buildFloatingSearchBar(context);
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final Client? client = context.authNotifier?.client;
    final User? user = context.authNotifier?.user;

    return FloatingSearchBar(
      hint: hint,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      // automaticallyImplyBackButton: true,
      scrollPadding: const EdgeInsets.only(/*top: 0, */bottom: 80),
      // padding: const EdgeInsets.symmetric(horizontal: 0),
      // backdropColor: Colors.transparent,
      margins: EdgeInsets.only(top: MediaQuery.of(context)
          .viewPadding.top.toDouble() + 8, bottom: 8.0, left: 16.0, right: 16),
      transitionDuration: const Duration(milliseconds: 200),
      borderRadius: BorderRadius.circular(8.0),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      // width: isPortrait ? 600 : 500,
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
                  color: Theme.of(context).iconTheme.color,
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
        FloatingSearchBarAction.back(
          color: Theme.of(context).iconTheme.color,
        ),
      ],
      actions: [
        FloatingSearchBarAction(
          child: CircularButton(
            icon: const CircleAvatar(
              radius: 16.0,
              child: Text('B'),
            ),
            onPressed: () {
              context.read(shouldShowBottomNavigationProvider).state = false;
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return const MoreScreen();
                },
                fullscreenDialog: true
              ));
            },
          ),
        ),
        FloatingSearchBarAction(
          child: PopupMenuButton(
            padding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
            offset: const Offset(0.0, kToolbarHeight),
            icon: const CircleAvatar(
              radius: 16.0,
              child: Text('A'),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              // Account
              PopupMenuItem(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (client != null && user != null)
                        CircleAvatar(
                          radius: 20.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: CachedNetworkImage(
                              imageUrl: '${client
                                  .endPoint}/avatars/initials?project=60a984c918aa7'
                                  '&name=${user.name}&width=100&height=100',
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                      if (client == null || user == null)
                        const CircleAvatar(
                          radius: 20.0,
                          child: Icon(Icons.no_accounts_outlined),
                        ),
                    ],
                  ),
                  title: const Text('Admin'),
                  subtitle: const Text('admin@shodana.app'),
                ),
              ),
              // Divider
              const PopupMenuDivider(height: 1,),
              // Incognito Mode
              PopupMenuItem(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  minLeadingWidth: 0.0,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.history_toggle_off_outlined),
                    ],
                  ),
                  title: const Text('Turn on Incognito mode'),
                  // subtitle: const Text('Pauses reading history'),
                ),
              ),
              // Settings
              PopupMenuItem(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  minLeadingWidth: 0.0,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.settings_outlined),
                    ],
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const MoreSettingsScreen();
                        })
                    );
                  },
                ),
              ),
              // About
              PopupMenuItem(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  minLeadingWidth: 0.0,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.info_outline),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('About', style: Theme.of(context).textTheme
                          .bodyText1,),
                      Text('v0.0.2', style: Theme.of(context).textTheme
                          .subtitle2,),
                    ],
                  ),
                  // subtitle: const Text('v0.0.2'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const AboutScreen();
                        })
                    );
                  },
                ),
              ),
              // Help
              PopupMenuItem(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  minLeadingWidth: 0.0,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.help_outline),
                    ],
                  ),
                  title: const Text('Help'),
                ),
              ),
            ],
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
            color: Theme.of(context).bottomAppBarTheme.color,
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
      body: FloatingSearchBarScrollNotifier(child: body ?? Container()),
    );
  }
}