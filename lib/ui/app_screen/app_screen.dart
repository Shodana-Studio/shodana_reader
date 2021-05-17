import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../data/provider/nav_current_index_provider.dart';
import '../../locations/locations.dart';
import 'app_screen_mobile.dart';
import 'app_screen_tablet.dart';

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
    // BeamerRouterDelegate(
    //   locationBuilder: (state) => DiscoverLocation(state),
    // ),
    BeamerRouterDelegate(
      locationBuilder: (state) => MoreLocation(state),
    ),
  ];



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentIndexProvider = context.read(navCurrentIndexProvider);
    int? _currentIndex;
    if (widget.beamState.uri.path.contains('books')) {
      _currentIndex = 0;
    } else if (widget.beamState.uri.path.contains('shelves')) {
      _currentIndex = 1;
    } else if (widget.beamState.uri.path.contains('clubs')) {
      _currentIndex = 2;
    }
    // else if (widget.beamState.uri.path.contains('discover'))
    // {
    //   _currentIndex = 3;
    // }
    else if (widget.beamState.uri.path.contains('more')) {
      // _currentIndex = 4;
      _currentIndex = 3;
    }
    if (_currentIndex != null) {
      currentIndexProvider.state = _currentIndex;
    }
  }

  void onNavigationItemTap(int index,
      StateController<int> currentIndexProvider) {
    if (currentIndexProvider.state == index) {
      _routerDelegates[currentIndexProvider.state].beamToNamed
        (_routerDelegates[currentIndexProvider.state].initialPath);
    } else {
      currentIndexProvider.state = index;
      _routerDelegates[currentIndexProvider.state].parent?.updateRouteInformation(
        _routerDelegates[currentIndexProvider.state].currentLocation.state.uri,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndexProvider = useProvider(navCurrentIndexProvider);
    final IndexedStack indexedStack = IndexedStack(
      key: const ValueKey('first'),
      index: currentIndexProvider.state,
      children: [
        Beamer(routerDelegate: _routerDelegates[0]),
        Beamer(routerDelegate: _routerDelegates[1]),
        Beamer(routerDelegate: _routerDelegates[2]),
        Beamer(routerDelegate: _routerDelegates[3]),
        // Beamer(routerDelegate: _routerDelegates[4]),
      ],
    );

    bottomNavigationBar = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(thickness: 1, height: 1),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          currentIndex: currentIndexProvider.state,
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
          onTap: (item) => onNavigationItemTap(item, currentIndexProvider),
        ),
      ],
    );

    navigationRail = NavigationRail(
      // leading: GestureDetector(
      //   onTap: () {},
      //   child: const ExtendableFab()
      // ),
      // extended: true,
      groupAlignment: 0.0,
      // backgroundColor: Theme.of(context).backgroundColor,
      // elevation: 8,
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
      selectedIndex: currentIndexProvider.state,
      onDestinationSelected: (item) => onNavigationItemTap(item, currentIndexProvider),
    );

    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => AppScreenMobile(
        bottomNavigationBar: bottomNavigationBar,
        navigationRail: navigationRail,
        indexedStack: indexedStack,
      ),
      tablet: (BuildContext context) => AppScreenTablet(
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

