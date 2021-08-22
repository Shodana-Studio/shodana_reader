import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'tile.dart';

class GridTileWidget extends Tile {
  const GridTileWidget({ 
    Key? key, 
    required index,
    required title, 
    subtitle = '', 
    unread = 0, 
    image,
  }) : super(key: key, index: index, title: title, subtitle: subtitle, unread: unread, image: image);

  @override
  Widget build(BuildContext context) {
    return buildStack();
  }

  Widget buildStack() {
    return Card(
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              //Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://i.imgur.com/DRLR1sN.png',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
    
    
  //   Stack(
  //   alignment: Alignment.topLeft,
  //   children: [
  //     Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         children: [
  //           Image.network('https://i.imgur.com/DRLR1sN.png'),
  //           Text(title),
  //         ],
  //       ),
  //     )
  //   ],
  // );
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);