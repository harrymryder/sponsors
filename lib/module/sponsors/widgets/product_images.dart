import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sponsors/module/sponsors/widgets/grid_big.dart';
import 'package:sponsors/module/sponsors/widgets/grid_six_small.dart';

import './product_image.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    required this.expanded,
    required this.images,
    Key? key,
  }) : super(key: key);

  final bool expanded;
  final List images;

  @override
  Widget build(BuildContext context) {
    final List<Map> _coverGridBigImage = [];
    final List<Map> _coverGridSmallImages = [];
    final List<Map> _leftoverBigImages = [];
    final List<Map> _leftoverSmallImages = [];
    final List<Map> _leftoverImages = [];

    //TODO: Put in init state
    //TODO: Get cover grid from grid generator
    for (Map image in images) {
      if (_coverGridBigImage.isEmpty && image['type'] == 'BIG_SQUARE') {
        _coverGridBigImage.add(image);
      } else if (_coverGridSmallImages.length < 2 &&
          image['type'] == 'SMALL_SQUARE') {
        _coverGridSmallImages.add(image);
      } else {
        if (image['type'] == 'BIG_SQUARE') {
          _leftoverBigImages.add(image);
          _leftoverImages.add(image);
        }
        if (image['type'] == 'SMALL_SQUARE') {
          _leftoverSmallImages.add(image);
          _leftoverImages.add(image);
        }
      }
    }

    bool _noMoreGrids = false;

    //TODO: Get other grids from grid generator
    List<Widget> _grids = [];

    while (!_noMoreGrids) {
      int _smallCount = _leftoverSmallImages.length;
      int _bigCount = _leftoverBigImages.length;

      if (_smallCount >= 6) {
        List _imagesToAdd = [];

        /// Add images
        for (var i = 0; i < 6; i++) {
          final Map _image = _leftoverSmallImages[i];
          _imagesToAdd.add(_image);
        }

        /// Create small image grid
        _grids.add(GridSixSmall(images: _imagesToAdd));

        /// Remove images
        for (var i = 0; i < 6; i++) {
          _leftoverSmallImages.removeAt(0);
        }
      } else if (_smallCount >= 2 && _bigCount >= 1) {
        List<String> _sides = ['right', 'left'];
        final _random = Random();
        final _randomSide = _sides[_random.nextInt(2)];
        List _imagesToAdd = [];

        /// Get and remove big image
        final Map _bigImage = _leftoverBigImages.first;

        /// Get small images
        for (var i = 0; i < 2; i++) {
          final Map _image = _leftoverSmallImages[i];
          _imagesToAdd.add(_image);
        }

        /// Create big image grid
        _grids.add(GridBig(
          smallImages: _imagesToAdd,
          bigImage: _bigImage,
          bigSide: _randomSide,
        ));

        /// Remove small images
        for (var i = 0; i < 2; i++) {
          _leftoverSmallImages.removeAt(0);
        }
      } else {
        _noMoreGrids = true;
      }
    }

    bool _hasGrids = _grids.isNotEmpty;

    dev.log(_hasGrids.toString());
    dev.log(_grids.toString());

    return Column(
      children: [
        _hasGrids
            ? GridBig(
                smallImages: _coverGridSmallImages,
                bigImage: _coverGridBigImage[0],
                bigSide: 'right',
              )
            : Container(),
        if (expanded && _hasGrids)
          for (Widget grid in _grids) grid,
      ],
    );
  }
}
