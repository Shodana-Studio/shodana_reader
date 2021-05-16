import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../data/provider/bottom_navigation_provider.dart';
import '../../locations/locations.dart';
import 'app_screen_mobile.dart';

class AppScreen extends StatefulHookWidget {
  const AppScreen({Key? key, required this.beamState}) : super(key: key);

  final BeamState beamState;

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  Widget? bottomNavigationBar;
  late NavigationRail navigationRail;

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
    // else if (widget.beamState.uri.path.contains('discover'))
    // {
    //   _currentIndex = 3;
    // }
    else if (widget.beamState.uri.path.contains('more'))
    {
      // _currentIndex = 4;
      _currentIndex = 3;
    }
    else
    {
      _currentIndex = 0;
    }

  }

  void onNavigationItemTap(int index) {
    if (_currentIndex == index) {
      _routerDelegates[_currentIndex].beamToNamed
        (_routerDelegates[_currentIndex].initialPath);
    } else {
      setState(() => _currentIndex = index);
      _routerDelegates[_currentIndex].parent?.updateRouteInformation(
        _routerDelegates[_currentIndex].currentLocation.state.uri,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool enableNav = useProvider(shouldShowBottomNavigationProvider)
        .state;

    final IndexedStack indexedStack = IndexedStack(
      index: _currentIndex,
      children: [
        Beamer(routerDelegate: _routerDelegates[0]),
        Beamer(routerDelegate: _routerDelegates[1]),
        Beamer(routerDelegate: _routerDelegates[2]),
        // Beamer(routerDelegate: _routerDelegates[3]),
        Beamer(routerDelegate: _routerDelegates[4]),
      ],
    );

    bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.homeBottomNavItemText,
            icon: const Icon(Icons.menu_book_rounded)
        ),
        BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.shelvesBottomNavItemText,
            icon: const Icon(Icons.collections_bookmark_rounded)
        ),
        BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.clubsBottomNavItemText,
            icon: const Icon(Icons.group_rounded)
        ),
        // BottomNavigationBarItem(
        //     label: AppLocalizations.of(context)!.discoverBottomNavItemText,
        //     icon: const Icon(Icons.explore_rounded)
        // ),
        BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.moreBottomNavItemText,
            icon: const Icon(Icons.more_horiz)
        ),
      ],
      onTap: onNavigationItemTap,
    );

    navigationRail = NavigationRail(
      // leading: const ExtendableFab(),
      // extended: true,
      groupAlignment: 0.0,
      labelType: NavigationRailLabelType.none,
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          label: Text(AppLocalizations.of(context)!.homeBottomNavItemText),
          icon: const Icon(Icons.menu_book_rounded),
        ),
        NavigationRailDestination(
          label: Text(AppLocalizations.of(context)!.shelvesBottomNavItemText),
          icon: const Icon(Icons.collections_bookmark_rounded)
        ),
        NavigationRailDestination(
          label: Text(AppLocalizations.of(context)!.clubsBottomNavItemText),
          icon: const Icon(Icons.group_rounded)
        ),
        // NavigationRailDestination(
        //   label: Text(AppLocalizations.of(context)!.discoverBottomNavItemText),
        //   icon: const Icon(Icons.explore_rounded)
        // ),
        NavigationRailDestination(
          label: Text(AppLocalizations.of(context)!.moreBottomNavItemText),
          icon: const Icon(Icons.more_horiz)
        ),
      ],
      selectedIndex: _currentIndex,
      onDestinationSelected: onNavigationItemTap,
    );

    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => AppScreenMobile(
        bottomNavigationBar: bottomNavigationBar,
        navigationRail: navigationRail,
        indexedStack: indexedStack,
      ),
      tablet: (BuildContext context) => AppScreenMobile(
        bottomNavigationBar: bottomNavigationBar,
        navigationRail: navigationRail,
        indexedStack: indexedStack,
      ),
      desktop: (BuildContext context) => AppScreenMobile(
        bottomNavigationBar: bottomNavigationBar,
        navigationRail: navigationRail,
        indexedStack: indexedStack,
      ),
      watch: (BuildContext context) => AppScreenMobile(
        bottomNavigationBar: bottomNavigationBar,
        navigationRail: navigationRail,
        indexedStack: indexedStack,
      ),
    );
  }
}

class ExtendableFab extends StatelessWidget {
  const ExtendableFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final Animation<double> animation = NavigationRail.extendedAnimation(context);
   return AnimatedBuilder(
     animation: animation,
     builder: (BuildContext context, Widget? child) {
       // The extended fab has a shorter height than the regular fab.
       return Container(
         height: 56,
         padding: EdgeInsets.symmetric(
           vertical: lerpDouble(0, 6, animation.value)!,
         ),
         child: animation.value == 0
           ? FloatingActionButton(
               onPressed: () {},
               child: const Icon(Icons.add),
             )
           : Align(
               alignment: AlignmentDirectional.centerStart,
               widthFactor: animation.value,
               child: Padding(
                 padding: const EdgeInsetsDirectional.only(start: 8),
                 child: FloatingActionButton.extended(
                   icon: const Icon(Icons.add),
                   label: const Text('UPLOAD'),
                   onPressed: () {},
                 ),
               ),
             ),
       );
     },
   );
  }
}
