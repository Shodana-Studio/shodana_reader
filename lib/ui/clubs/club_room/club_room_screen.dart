import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'club_room_screen_mobile.dart';

class ClubRoomScreen extends StatelessWidget {
  const ClubRoomScreen({Key? key, required this.club}) : super(key: key);
  final Map<String, String> club;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ClubRoomScreenMobile(
        club: club,
      ),
      tablet: (BuildContext context) => ClubRoomScreenMobile(
          club: club,
      ),
      desktop: (BuildContext context) => ClubRoomScreenMobile(
          club: club,
      ),
      watch: (BuildContext context) => ClubRoomScreenMobile(
          club: club,
      ),
    );
  }
}

