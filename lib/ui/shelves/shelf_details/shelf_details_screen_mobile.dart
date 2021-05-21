import 'package:flutter/material.dart';

class ShelfDetailsScreenMobile extends StatelessWidget {
  const ShelfDetailsScreenMobile({
    Key? key,
    required this.beamToBook,
    required this.shelf,
  }) : super(key: key);
  final Function(BuildContext, String, String) beamToBook;
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
            onPressed: () => beamToBook(context, '0', '0'),
            child: const Text('Beam to Test Book 0 Details'),
          ),
        ],
      ),
    );
  }
}