import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shodana_reader/data/provider/starting_screen_provider.dart';
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

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final bool lastUsedEnabled = context.read(lastUsedEnabledProvider).state;
    final int lastUsedIndex = context.read(lastUsedIndexProvider).state;
    final int defaultStartingPage = context.read(defaultStartingPageProvider);

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
    } else {
      if (lastUsedEnabled) {
        _currentIndex = lastUsedIndex;
      } else {
        _currentIndex = defaultStartingPage;
      }
    }
  }

  void onNavigationItemTap(int index, StateController<bool> lastUsedEnabled,
      StateController<int> lastUsedIndex) {
    if (_currentIndex == index) {
      _routerDelegates[_currentIndex].beamToNamed
        (_routerDelegates[_currentIndex].initialPath);
    } else {
      setState(() => _currentIndex = index);
      if (lastUsedEnabled.state) {
        lastUsedIndex.state = _currentIndex;
      }
      _routerDelegates[_currentIndex].parent?.updateRouteInformation(
        _routerDelegates[_currentIndex].currentLocation.state.uri,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final StateController<bool> lastUsedEnabled = context.read
      (lastUsedEnabledProvider);
    final StateController<int> lastUsedIndex = context.read
      (lastUsedIndexProvider);

    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
          systemNavigationBarDividerColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: AdaptiveTheme.of(context).darkTheme.backgroundColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
          systemNavigationBarDividerColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: AdaptiveTheme.of(context).lightTheme.backgroundColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }

    final IndexedStack indexedStack = IndexedStack(
      key: const ValueKey('first'),
      index: _currentIndex,
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
          currentIndex: _currentIndex,
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
          onTap: (i) => onNavigationItemTap(i, lastUsedEnabled, lastUsedIndex),
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
      selectedIndex: _currentIndex,
      onDestinationSelected: (i) => onNavigationItemTap(i, lastUsedEnabled, lastUsedIndex),
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

