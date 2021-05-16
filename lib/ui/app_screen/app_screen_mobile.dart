import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../data/provider/left_navigation_rail_provider.dart';
import '../../data/provider/bottom_navigation_provider.dart';

class AppScreenMobile extends HookWidget {
  const AppScreenMobile({Key? key,
    required this.indexedStack,
    this.bottomNavigationBar, required this.navigationRail}) : super(key: key);

  final IndexedStack indexedStack;
  final Widget? bottomNavigationBar;
  final NavigationRail navigationRail;


  @override
  Widget build(BuildContext context) {
    final bool enableNav = useProvider(shouldShowBottomNavigationProvider)
        .state;
    final bool leftRail = useProvider(leftNavigationRailProvider);

    final Row railRow;

    if (leftRail) {
      railRow = Row(
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
          Expanded(child: indexedStack),
        ],
      );
    } else {
      railRow = Row(
        children: <Widget>[
          Expanded(child: indexedStack),
          if (enableNav)
            const VerticalDivider(thickness: 1, width: 1),
          if (enableNav)
            SafeArea(child: LayoutBuilder(
              builder: (context, constraint) => SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(child: navigationRail)
                ),
              ),
            )),
        ],
      );
    }

    return OrientationLayoutBuilder(
      portrait: (context) => Scaffold(
        body: indexedStack,
        bottomNavigationBar: enableNav ? bottomNavigationBar : Container(),
      ),
      landscape: (context) => Scaffold(
        body: railRow,
      ),
    );
  }
}
