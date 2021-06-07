import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/data/model/book_search_model.dart';
import '../../core/presentation/locations/locations.dart';
import '../../core/res/constants.dart';
import '../../my.i18n.dart';
import '../auth/login_screen.dart';
import '../widgets/search_bar.dart';
import 'app_screen_mobile.dart';
import 'app_screen_tablet.dart';
import 'provider/default_starting_page_provider.dart';
import 'provider/last_used_enabled_provider.dart';
import 'provider/last_used_index_provider.dart';

class AppScreen extends StatefulHookWidget {
  const AppScreen({Key? key, required this.beamState}) : super(key: key);

  final BeamState beamState;

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  Widget? bottomNavigationBar;
  late NavigationRail navigationRail;
  late int currentIndex;
  late final List<BeamerDelegate<BeamState>> _routerDelegates;

  // These are all the location handlers. They handle the page stacks.
  List<BeamerDelegate> getRouterDelegates(BuildContext rootContext) => [
      BeamerDelegate(
        initialPath: '/home',
        locationBuilder: (state) {
        if (state.uri.path.contains('home')) {
          return HomeLocation(state, rootContext);
        }
          return NotFound(path: state.uri.toString());
        },
      ),
      BeamerDelegate(
        initialPath: '/shelves',
        locationBuilder: (state) {
          if (state.uri.path.contains('shelves')) {
            return ShelvesLocation(state, rootContext);
          }
          return NotFound(path: state.uri.toString());
        },
      ),
      BeamerDelegate(
        initialPath: '/clubs',
        locationBuilder: (state) {
          if (state.uri.path.contains('clubs')) {
            return ClubsLocation(state, rootContext);
          }
          return NotFound(path: state.uri.toString());
        },
      ),
      BeamerDelegate(
        initialPath: '/discover',
        locationBuilder: (state) {
          if (state.uri.path.contains('discover')) {
            return DiscoverLocation(state, rootContext);
          }
          return NotFound(path: state.uri.toString());
        },
      ),
      // BeamerDelegate(
      //   initialPath: '/more',
      //   locationBuilder: (state) {
      //     if (state.uri.path.contains('more')) {
      //       return MoreLocation(state);
      //     }
      //     return NotFound(path: state.uri.toString());
      //   },
      // ),
    ];

  @override
  void initState() {
    super.initState();
    _routerDelegates = getRouterDelegates(context);

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final bool lastUsedEnabled = context.read(lastUsedEnabledProvider);
    final lastUsedIndexNotifier = context.read(lastUsedIndexProvider.notifier);
    final int defaultStartingPage = context.read(defaultStartingPageProvider);

    if (widget.beamState.uri.path.contains('home')) {
      currentIndex = 0;
    } else if (widget.beamState.uri.path.contains('shelves')) {
      currentIndex = 1;
    } else if (widget.beamState.uri.path.contains('clubs')) {
      currentIndex = 2;
    } else if (widget.beamState.uri.path.contains('discover')) {
      currentIndex = 3;
    // } else if (widget.beamState.uri.path.contains('more')) {
    //   currentIndex = 4;
    } else {
      // If the user has the default screen set to last used, launch the screen
      // to the last used screen. Otherwise launch to the default screen
      // selected by the user
      if (lastUsedEnabled) {
        currentIndex = lastUsedIndexNotifier.getPage();
      } else {
        currentIndex = defaultStartingPage;
      }
    }

    lastUsedIndexNotifier.setPage(currentIndex);
    // if (currentIndex != 4) {
    //   lastUsedIndexNotifier.setPage(currentIndex);
    // }

    // Set the current index to active, all others to not active
    int i = 0;
    for ( i = 0; i < _routerDelegates.length; i++ ) {
      if (currentIndex == i) {
        _routerDelegates[i].active();
      } else {
        _routerDelegates[i].active(false);
      }
    }

  }

  void onNavigationItemTap(int index, LastUsedIndex lastUsedIndex) {
    if (currentIndex == index) {
      _routerDelegates[currentIndex].beamToNamed
        (_routerDelegates[currentIndex].initialPath);
    } else {
      setState(() => currentIndex = index);

      int i = 0;
      for ( i = 0; i < _routerDelegates.length; i++ ) {
        if (currentIndex == i) {
          _routerDelegates[i].active();
        } else {
          _routerDelegates[i].active(false);
        }
      }

      // Always keep track of the last used index unless its the 'more' page
      if (index != 4) {
        lastUsedIndex.setPage(currentIndex);
      }

      _routerDelegates[currentIndex].update(rebuild: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rootContext = context;
    final authNotifier = context.authNotifier;
    // final StateController<bool> lastUsedEnabled = context.read
    //   (lastUsedEnabledProvider);
    final LastUsedIndex lastUsedIndex = context.read
      (lastUsedIndexProvider.notifier);

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
      index: currentIndex,
      children: [
        Beamer(routerDelegate: _routerDelegates[0]),
        Beamer(routerDelegate: _routerDelegates[1]),
        Beamer(routerDelegate: _routerDelegates[2]),
        Beamer(routerDelegate: _routerDelegates[3]),
        // Beamer(routerDelegate: routerDelegates[4]),
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
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.menu_book_rounded)
            ),
            BottomNavigationBarItem(
                label: 'Shelves',
                icon: Icon(Icons.collections_bookmark_rounded)
            ),
            BottomNavigationBarItem(
                label: 'Clubs',
                icon: Icon(Icons.group_rounded)
            ),
            BottomNavigationBarItem(
                label: 'Discover',
                icon: Icon(Icons.explore_rounded)
            ),
            // BottomNavigationBarItem(
            //     label: TR.of(context)!.moreBottomNavItemText,
            //     icon: const Icon(Icons.more_horiz)
            // ),
          ],
          onTap: (i) => onNavigationItemTap(i, lastUsedIndex),
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
          label: Text('Home'.i18n),
          icon: const Icon(Icons.menu_book_rounded),
        ),
        NavigationRailDestination(
          label: Text('Shelves'.i18n),
          icon: const Icon(Icons.collections_bookmark_rounded)
        ),
        NavigationRailDestination(
          label: Text('Clubs'.i18n),
          icon: const Icon(Icons.group_rounded)
        ),
        NavigationRailDestination(
          label: Text('Discover'.i18n),
          icon: const Icon(Icons.explore_rounded)
        ),
        // NavigationRailDestination(
        //   label: Text(TR.of(context)!.moreBottomNavItemText),
        //   icon: const Icon(Icons.more_horiz)
        // ),
      ],
      selectedIndex: currentIndex,
      onDestinationSelected: (i) => onNavigationItemTap(i, lastUsedIndex),
    );


    Widget widget;
    switch(authNotifier?.status ?? AuthStatus.uninitialized) {
      case AuthStatus.authenticated:
        widget = ValueListenableBuilder(
          valueListenable: Hive.box(AppConstant.settingsBoxKey).listenable(),
          builder: (context, Box box, child) =>
            box.get(AppConstant.welcomeShown, defaultValue: false)
              ? ScreenTypeLayout.builder(
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
                )
              : WelcomePage(rootContext: rootContext)
        );
        break;
      case AuthStatus.unauthenticated:
      case AuthStatus.authenticating:
        widget = const LoginScreen();
        break;
      case AuthStatus.uninitialized:
        widget = const LoadingScreen();
        break;
    }

    return widget;
  }
}

class WelcomePage extends HookWidget {
  const WelcomePage({ Key? key, required this.rootContext }) : super(key: key);
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    final BookSearchModel searchModel = useProvider(bookSearchProvider);
    return Scaffold(
      body: SearchBar(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Welcome Page'),
              ElevatedButton(
                onPressed: () async {
                  final box = Hive.box(AppConstant.settingsBoxKey);
                  unawaited(box.put(AppConstant.welcomeShown, true));
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
        hint: 'Welcome!',
        model: searchModel,
        rootContext: rootContext
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}