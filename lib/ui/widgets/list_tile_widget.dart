import 'dart:io' as io;
import 'package:flutter/material.dart';

import 'tile.dart';

class ListTileWidget extends Tile {
  const ListTileWidget({ 
    Key? key, 
    required title, 
    subtitle = '', 
    unread = 0, 
    image,
    required this.context,
  }) : super(key: key, title: title, subtitle: subtitle, unread: unread, image: image);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return buildStack();
  }

  Widget buildStack() {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              // flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(io.File(image), filterQuality: FilterQuality.medium),
              ),
            ),
            const SizedBox(width: 8,),
            Flexible(
              flex: 6,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyText2,),
                  if (subtitle.isNotEmpty) Text(subtitle, style: textTheme.subtitle2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}