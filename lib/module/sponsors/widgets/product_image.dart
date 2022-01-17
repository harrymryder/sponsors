import 'package:flutter/material.dart';

import '../../../theme.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.src,
    required this.width,
    Key? key,
  }) : super(key: key);

  final String src;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        boxShadow: smallShadow,
        borderRadius: BorderRadius.circular(1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: Image.network(
          src,
          width: width,
          height: width,
        ),
      ),
    );
  }
}
