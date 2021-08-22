import 'dart:io' as io;
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'tile.dart';

class ListTileWidget extends Tile {
  const ListTileWidget({ 
    Key? key, 
    required index,
    required title, 
    subtitle = '', 
    unread = 0, 
    image,
    required this.context,
  }) : super(key: key, index: index, title: title, subtitle: subtitle, unread: unread, image: image);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return buildStack();
  }

  Widget buildStack() {
    final textTheme = AdaptiveTheme.of(context).theme.textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                io.File.fromUri(Uri(path: image)),
                height: 120,
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyText1,),
                  if (subtitle.isNotEmpty) Text(subtitle, style: textTheme.subtitle1,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}