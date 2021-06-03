import 'package:beamer/beamer.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';

import '../../../core/data/repository/fake_data.dart';
import '../../../ui/auth/login_screen.dart';
import '../../../ui/clubs/club_room/club_room_screen.dart';
import '../../../ui/clubs/clubs_screen.dart';

class ClubsLocation extends BeamLocation {
  ClubsLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/clubs/:clubId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('clubs'),
      title: 'Clubs - Shodana Reader',
      type: BeamPageType.noTransition,
      child: const ClubsScreen(),
    ),
    if (state.pathParameters.containsKey('clubId'))
      BeamPage(
        key: ValueKey('club-${state.pathParameters['clubId']}'),
        child: ClubRoomScreen(
          club: club,
        ),
      ),
  ];

  // in your location implementation
  @override
  List<BeamGuard> get guards => [
    // Show forbiddenPage if the user tries to enter clubs:
    BeamGuard(
      pathBlueprints: ['/clubs', 'clubs/*'],
      check: (context, location) =>
        (context.authNotifier?.status ?? AuthStatus.uninitialized)
            == AuthStatus.authenticated || 
        (context.authNotifier?.status ?? AuthStatus.uninitialized)
            == AuthStatus.uninitialized,
      showPage: BeamPage(
        key: const ValueKey('login'),
        child: const LoginPage(),
      ),
    ),
  ];
}