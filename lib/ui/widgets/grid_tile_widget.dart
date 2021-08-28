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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FutureBuilder(
            //   future: imageFile.readAsBytes(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(8),
            //         child: Image.file(imageFile),
            //       );
            //     }

            //     return const Placeholder();
            //   },
            // ),
            Image.file(imageFile),
            const SizedBox(height: 8,),
            Text(title, style: textTheme.bodyText2),
            if (subtitle.isNotEmpty) ... [
              Text(subtitle, style: textTheme.subtitle2),
            ]
          ],
        ),
      ),
    );
  }
}