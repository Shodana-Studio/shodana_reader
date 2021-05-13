import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:shodana_reader/core/locations/books_location.dart';
import 'package:shodana_reader/core/locations/clubs_location.dart';
import 'package:shodana_reader/core/locations/discover_location.dart';
import 'package:shodana_reader/core/locations/more_location.dart';
import 'package:shodana_reader/core/locations/shelves_location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key, required this.beamState}) : super(key: key);

  final BeamState beamState;

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  // These are all the location handlers. They handle the page stacks.
  final _routerDelegates = [
    BeamerRouterDelegate(
      locationBuilder: (state) => BooksLocation(state),
    ),
    BeamerRouterDelegate(
      locationBuilder: (state) => ShelvesLocation(state),
    ),
    BeamerRouterDelegate(
      locationBuilder: (state) => ClubsLocation(state),
    ),
    BeamerRouterDelegate(
      locationBuilder: (state) => DiscoverLocation(state),
    ),
    BeamerRouterDelegate(
      locationBuilder: (state) => MoreLocation(state),
    ),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.beamState.uri.path.contains('books'))
    {
      _currentIndex = 0;
    }
    else if (widget.beamState.uri.path.contains('shelves'))
    {
      _currentIndex = 1;
    }
    else if (widget.beamState.uri.path.contains('clubs'))
    {
      _currentIndex = 2;
    }
    else if (widget.beamState.uri.path.contains('discover'))
    {
      _currentIndex = 3;
    }
    else if (widget.beamState.uri.path.contains('more'))
    {
      _currentIndex = 4;
    }
    else
    {
      _currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Beamer(routerDelegate: _routerDelegates[0]),
          Beamer(routerDelegate: _routerDelegates[1]),
          Beamer(routerDelegate: _routerDelegates[2]),
          Beamer(routerDelegate: _routerDelegates[3]),
          Beamer(routerDelegate: _routerDelegates[4]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              label: AppLocalizations.of(context)?.homeBottomNavItemText
              ?? 'No Name', icon: const Icon(Icons.menu_book_rounded)
          ),
          BottomNavigationBarItem(
              label: AppLocalizations.of(context)?.shelvesBottomNavItemText
              ?? 'No Name', icon: const Icon(Icons.collections_bookmark_rounded)
          ),
          BottomNavigationBarItem(
              label: AppLocalizations.of(context)?.clubsBottomNavItemText
              ?? 'No Name', icon: const Icon(Icons.group_rounded)
          ),
          BottomNavigationBarItem(
              label: AppLocalizations.of(context)?.discoverBottomNavItemText
              ?? 'No Name', icon: const Icon(Icons.explore_rounded)
          ),
          BottomNavigationBarItem(
              label: AppLocalizations.of(context)?.moreBottomNavItemText
              ?? 'No Name', icon: const Icon(Icons.more_horiz)
          ),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (_currentIndex == index) {
            _routerDelegates[_currentIndex].beamToNamed(widget.beamState.uri.path);
          } else {
            setState(() => _currentIndex = index);
            _routerDelegates[_currentIndex].parent?.updateRouteInformation(
              _routerDelegates[_currentIndex].currentLocation.state.uri,
            );
          }
        },
      ),
    );
  }
}