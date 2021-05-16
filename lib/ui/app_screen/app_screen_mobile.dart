import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppScreenMobile extends StatelessWidget {
  const AppScreenMobile({Key? key,
    required this.indexedStack, required this.enableBottomNav,
    this.bottomNavigationBar, required this.navigationRail}) : super(key: key);

  final IndexedStack indexedStack;
  final bool enableBottomNav;
  final Widget? bottomNavigationBar;
  final NavigationRail navigationRail;


  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (context) => Scaffold(
        body: indexedStack,
        bottomNavigationBar: enableBottomNav? bottomNavigationBar : Container(),
      ),
      landscape: (context) => Scaffold(
        body: Row(
          children: <Widget>[
            SafeArea(child: LayoutBuilder(
              builder: (context, constraint) => SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(child: navigationRail)
                ),
              ),
            )
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: indexedStack),
          ],
        ),
      ),
    );
  }
}
