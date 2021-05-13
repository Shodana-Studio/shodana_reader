import 'package:flutter/material.dart';

class DiscoverDetailsScreen extends StatelessWidget {
  const DiscoverDetailsScreen({Key? key, required this.internetBook}) : super(key: key);
  final Map<String, String> internetBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(internetBook['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Author: ${internetBook['author']}'),
      ),
    );
  }
}