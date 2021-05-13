import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shodana_reader/core/providers/bottom_navigation_provider.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({Key? key, required this.book, required this.chapter}) : super(key: key);
  final Map<String, String> book;
  final List<String> chapter;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read(shouldShowBottomNavigationProvider).state = true;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reading: ${chapter.first}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Chapter Contents: ${chapter[1]}'),
        ),
      ),
    );
  }
}