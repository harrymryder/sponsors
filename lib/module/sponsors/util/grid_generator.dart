import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/big_grid.dart';
import '../widgets/small_grid.dart';

class GridGenerator {
  static Map<String, dynamic> generateGrid(List images) {
    final Map<String, dynamic> _result = {};

    final List<Map> _coverGridBigImage = [];
    final List<Map> _coverGridSmallImages = [];
    final List<Map> _leftoverBigImages = [];
    final List<Map> _leftoverSmallImages = [];
    final List<Map> _leftoverImages = [];

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

    if (_coverGridBigImage.isNotEmpty && _coverGridSmallImages.length == 2) {
      _result['coverGrid'] = GridBig(
        smallImages: _coverGridSmallImages,
        bigImage: _coverGridBigImage[0],
        bigSide: 'right',
      );
    }

    bool _noMoreGrids = false;
    List<Widget> _expandedGrids = [];

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
        _expandedGrids.add(GridSixSmall(images: _imagesToAdd));

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
        _leftoverBigImages.removeAt(0);

        /// Get small images
        for (var i = 0; i < 2; i++) {
          final Map _image = _leftoverSmallImages[i];
          _imagesToAdd.add(_image);
        }

        /// Create big image grid
        _expandedGrids.add(GridBig(
          smallImages: _imagesToAdd,
          bigImage: _bigImage,
          bigSide: _randomSide,
        ));

        /// Remove small images from leftover list
        for (var i = 0; i < 2; i++) {
          _leftoverSmallImages.removeAt(0);
        }
      } else {
        _noMoreGrids = true;
      }
    }

    if (_expandedGrids.isNotEmpty) {
      _result['expandedGrids'] = _expandedGrids;
    }

    return _result;
  }
}
