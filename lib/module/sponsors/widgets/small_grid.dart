import 'package:flutter/material.dart';

import './product_image.dart';

class SmallGrid extends StatelessWidget {
  const SmallGrid({required this.images, Key? key}) : super(key: key);

  final List images;
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _smallImageWidth = (_screenWidth * (1 / 3)) - 18;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            ProductImage(
              src: images[0]['smallImgUrl'],
              width: _smallImageWidth,
            ),
            ProductImage(
              src: images[1]['smallImgUrl'],
              width: _smallImageWidth,
            ),
          ],
        ),
        Column(
          children: [
            ProductImage(
              src: images[2]['smallImgUrl'],
              width: _smallImageWidth,
            ),
            ProductImage(
              src: images[3]['smallImgUrl'],
              width: _smallImageWidth,
            ),
          ],
        ),
        Column(
          children: [
            ProductImage(
              src: images[4]['smallImgUrl'],
              width: _smallImageWidth,
            ),
            ProductImage(
              src: images[5]['smallImgUrl'],
              width: _smallImageWidth,
            ),
          ],
        ),
      ],
    );
  }
}
