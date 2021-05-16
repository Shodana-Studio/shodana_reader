import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../data/repository/fake_data.dart';
import '../ui/clubs/club_room_screen.dart';
import '../ui/clubs/clubs_screen.dart';

class ClubsLocation extends BeamLocation {
  ClubsLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/clubs/:clubId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: const ValueKey('clubs'),
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
}