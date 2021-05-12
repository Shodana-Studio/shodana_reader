import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../locations/books_location.dart';
import '../locations/clubs_location.dart';
import '../locations/discover_location.dart';
import '../locations/more_location.dart';
import '../locations/shelves_location.dart';

class AppScreen extends StatefulWidget {
  AppScreen({required this.beamState});

  final BeamState beamState;

  @override
  _AppScreenState createState() => _AppScreenState();
}

// These are all the location handlers. They handle the page stacks.
final routerDelegates = [
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

class _AppScreenState extends State<AppScreen> {
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
          Beamer(routerDelegate: routerDelegates[0]),
          Beamer(routerDelegate: routerDelegates[1]),
          Beamer(routerDelegate: routerDelegates[2]),
          Beamer(routerDelegate: routerDelegates[3]),
          Beamer(routerDelegate: routerDelegates[4]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(label: 'Books', icon: Icon(Icons.menu_book_rounded)),
          BottomNavigationBarItem(label: 'Shelves', icon: Icon(Icons.collections_bookmark_rounded)),
          BottomNavigationBarItem(label: 'Clubs', icon: Icon(Icons.group_rounded)),
          BottomNavigationBarItem(label: 'Discover', icon: Icon(Icons.explore_rounded)),
          BottomNavigationBarItem(label: 'More', icon: Icon(Icons.menu_rounded)),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (_currentIndex == index) {
            routerDelegates[_currentIndex].beamToNamed(widget.beamState.uri.path);
          } else {
            setState(() => _currentIndex = index);
            routerDelegates[_currentIndex].parent?.updateRouteInformation(
              routerDelegates[_currentIndex].currentLocation.state.uri,
            );
          }
        },
      ),
    );
  }
}