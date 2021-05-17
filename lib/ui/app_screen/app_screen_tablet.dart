import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../data/provider/bottom_navigation_provider.dart';
import '../../data/provider/left_navigation_rail_provider.dart';

class AppScreenTablet extends HookWidget {
  const AppScreenTablet({Key? key,
    required this.indexedStack,
    this.bottomNavigationBar,
    required this.navigationRail,}) : super(key: key);
  final IndexedStack indexedStack;
  final Widget? bottomNavigationBar;
  final NavigationRail navigationRail;


  @override
  Widget build(BuildContext context) {
    final bool enableNav = useProvider(shouldShowBottomNavigationProvider)
        .state;
    final bool isLeftRail = useProvider(leftNavigationRailProvider);

    final Widget railRow;

    if (isLeftRail) {
      railRow = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (enableNav)
            LayoutBuilder(
              builder: (context, constraint) => SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(child: navigationRail)
                ),
              ),
            ),
          if (enableNav)
            const VerticalDivider(thickness: 1, width: 1),
        ],
      );
    } else {
      railRow = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (enableNav)
            const VerticalDivider(thickness: 1, width: 1),
          if (enableNav)
            LayoutBuilder(
              builder: (context, constraint) => SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(child: navigationRail)
                ),
              ),
            ),
        ],
      );
    }


    return OrientationLayoutBuilder(
      portrait: (context) => Scaffold(
        body: indexedStack,
        bottomNavigationBar: enableNav ? bottomNavigationBar : null,
      ),
      landscape: (context) => Scaffold(
        body: Row(
          children: [
            Expanded(child: indexedStack),
            railRow
            // TwoPageLayout(
            //   secondChild: railRow,
            //   child: railRow,
            // ),
          ],
        ),
      ),
    );
  }
}

// Scaffold(
//   body: railRow,
// ),