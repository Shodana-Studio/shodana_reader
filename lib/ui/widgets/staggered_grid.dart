import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'grid_tile_widget.dart';

class StaggeredGrid extends StatelessWidget {
  const StaggeredGrid({ Key? key, required this.controller }) : super(key: key);
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      controller: controller,
      crossAxisCount: 3,
      children: const [
        GridTileWidget(index: 1, title: 'Book 1'),
        GridTileWidget(index: 2, title: 'Book 2'),
        GridTileWidget(index: 3, title: 'Book 3'),
        GridTileWidget(index: 4, title: 'Book 4'),
        GridTileWidget(index: 5, title: 'Book 5'),
        GridTileWidget(index: 6, title: 'Book 6'),
      ],
    );
  }
}