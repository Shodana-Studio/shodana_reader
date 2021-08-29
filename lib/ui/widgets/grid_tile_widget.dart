import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'tile.dart';

class GridTileWidget extends Tile {
  const GridTileWidget({ 
    Key? key,
    required title, 
    subtitle = '', 
    unread = 0, 
    required image,
    required this.context,
  }) : super(key: key, title: title, subtitle: subtitle, unread: unread, image: image);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return buildStack();
  }

  Widget buildStack() {
    final textTheme = Theme.of(context).textTheme;
    final io.File imageFile = io.File(image);
    return Card(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: Add fade in
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: Image.file(imageFile, filterQuality: FilterQuality.medium, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.bodyText2),
                if (subtitle.isNotEmpty) ... [
                  Text(subtitle, style: textTheme.subtitle2),
                ]
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}