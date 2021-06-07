import 'package:flutter/material.dart';
import '../../../l10n/my.i18n.dart';

class ClubRoomScreenMobile extends StatelessWidget {
  const ClubRoomScreenMobile({
    Key? key,
    required this.club,
  }) : super(key: key);

  final Map<String, String> club;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Last Message: %s'.i18n.fill([club['last_message']!])),
      ),
    );
  }
}