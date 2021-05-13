import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/core/providers/bottom_navigation_provider.dart';

class ClubRoomScreen extends StatelessWidget {
  const ClubRoomScreen({Key? key, required this.club}) : super(key: key);
  final Map<String, String> club;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read(shouldShowBottomNavigationProvider).state = true;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(club['name']!),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Last Message: ${club['last_message']}'),
        ),
      ),
    );
  }
}