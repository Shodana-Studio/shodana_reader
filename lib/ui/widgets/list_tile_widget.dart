import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'tile.dart';

class ListTileWidget extends Tile {
  const ListTileWidget({ 
    Key? key, 
    required title, 
    subtitle = '', 
    unread = 0, 
    image,
    this.trailing,
  }) : super(key: key, title: title, subtitle: subtitle, unread: unread, image: image);
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return buildStack(context);
  }

  Widget buildStack(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double imageSizeMultiplier = getValueForScreenType<double>(
      context: context,
      mobile: 0.28,
      tablet: 0.08,
      desktop: 0.06,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Add fade in
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * imageSizeMultiplier,
                maxHeight: MediaQuery.of(context).size.width * imageSizeMultiplier,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.file(io.File(image), fit: BoxFit.cover, filterQuality: FilterQuality.medium),
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyText2,),
                  if (subtitle.isNotEmpty) Text(subtitle, style: textTheme.subtitle2),
                ],
              ),
            ),
            // TODO: Add feedback when able to drag
            Container(
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}