import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class ShelfDetailsScreen extends StatelessWidget {
  const ShelfDetailsScreen({Key? key, required this.shelf}) : super(key: key);
  final Map<String, String> shelf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf['name']!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Author: ${shelf['author']}'),
          ),
          const SizedBox(height: 8.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Books:', style: TextStyle(
              fontWeight: FontWeight.bold
            )),
          ),
          TextButton(
            onPressed: () {
              return context.beamToNamed('/shelves/0/0}');
            },
            child: const Text('Beam to Test Book 0 Details'),
          ),
        ],
      ),
    );
  }
}