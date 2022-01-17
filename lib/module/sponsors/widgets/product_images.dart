import 'package:flutter/material.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    required this.expanded,
    required this.coverGrid,
    required this.expandedGrids,
    Key? key,
  }) : super(key: key);

  final bool expanded;
  final Widget coverGrid;
  final List expandedGrids;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        coverGrid,
        if (expanded)
          for (Widget grid in expandedGrids) grid,
      ],
    );
  }
}
