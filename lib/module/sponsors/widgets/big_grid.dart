import 'package:flutter/material.dart';

import './product_image.dart';

class BigGrid extends StatelessWidget {
  const BigGrid({
    required this.smallImages,
    required this.bigImage,
    required this.bigSide,
    Key? key,
  }) : super(key: key);

  final List smallImages;
  final Map bigImage;
  final String bigSide;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _smallImageWidth = (_screenWidth * (1 / 3)) - 18;
    final double _bigImageWidth = (_screenWidth * (2 / 3)) - 28;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (bigSide == 'left')
          ProductImage(
            src: bigImage['smallImgUrl'],
            width: _bigImageWidth,
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductImage(
              src: smallImages[0]['smallImgUrl'],
              width: _smallImageWidth,
            ),
            ProductImage(
              src: smallImages[1]['smallImgUrl'],
              width: _smallImageWidth,
            ),
          ],
        ),
        if (bigSide == 'right')
          ProductImage(
            src: bigImage['smallImgUrl'],
            width: _bigImageWidth,
          ),
      ],
    );
  }
}
