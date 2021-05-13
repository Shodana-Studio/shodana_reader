import 'package:flutter/material.dart';

class MoreDetailsScreen extends StatelessWidget {
  const MoreDetailsScreen({Key? key, required this.option}) : super(key: key);
  final Map<String, String> option;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(option['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Description: ${option['description']}'),
      ),
    );
  }
}