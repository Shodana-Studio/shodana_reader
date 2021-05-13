import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/core/providers/bottom_navigation_provider.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Map<String, String> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Author: ${book['author']}'),
          ),
          TextButton(
            onPressed: () {
              context.read(shouldShowBottomNavigationProvider).state = false;
              // Beam to different locations depending on the current page stack
              if (Beamer.of(context).currentLocation.state
                  .pathBlueprintSegments.first == 'shelves') {
                return context.beamToNamed('/shelves/0/0/1}');
              } else {
                return context.beamToNamed('/books/0/1}');
              }
            },
            child: const Text('Start Reading'),
          ),
        ],
      ),
    );
  }
}