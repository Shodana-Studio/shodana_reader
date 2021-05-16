import 'package:flutter/material.dart';

class ClubRoomScreen extends StatelessWidget {
  const ClubRoomScreen({Key? key, required this.club}) : super(key: key);
  final Map<String, String> club;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Last Message: ${club['last_message']}'),
      ),
    );
  }
}