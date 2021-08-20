import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../core/data/repository/fake_data.dart';
import '../../../l10n/my.i18n.dart';
import '../../../ui/clubs/club_room/club_room_screen.dart';
import '../../../ui/clubs/clubs_screen.dart';
class ClubsLocation extends BeamLocation {
  ClubsLocation(BeamState state, this.rootContext) : super(state);
  final BuildContext rootContext;

  @override
  List<String> get pathBlueprints => ['/clubs/:clubId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('clubs'),
      title: 'Clubs - Shodana Reader'.i18n,
      type: BeamPageType.noTransition,
      child: ClubsScreen(rootContext: rootContext),
    ),
    if (state.pathParameters.containsKey('clubId'))
      BeamPage(
        key: ValueKey('club-${state.pathParameters['clubId']}'),
        child: ClubRoomScreen(
          club: club,
          rootContext: rootContext
        ),
      ),
  ];

  // @override
  // List<BeamGuard> get guards => [
  //   // Show forbiddenPage if the user tries to enter clubs:
  //   BeamGuard(
  //     pathBlueprints: ['/clubs', 'clubs/*'],
  //     check: (context, location) =>
  //       (context.authNotifier.status)
  //           == AuthStatus.authenticated || 
  //       (context.authNotifier.status)
  //           == AuthStatus.uninitialized,
  //     showPage: BeamPage(
  //       key: const ValueKey('login'),
  //       child: const LoginScreen(),
  //     ),
  //   ),
  // ];
}