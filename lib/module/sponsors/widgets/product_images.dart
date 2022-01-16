import 'dart:developer';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

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
    double _screenWidth = MediaQuery.of(context).size.width;
    double _smallImageWidth = (_screenWidth * (1 / 3)) - 16;
    double _bigImageWidth = (_screenWidth * (2 / 3)) - 24;

    List _firstRow = [];
    List _firstRowSmall = [];
    List _firstRowBig = [];
    List _secondRow = [];
    List _thirdRow = [];
    List _fourthRowSmall = [];
    List _fourthRowBig = [];

    for (Map image in images) {
      if (_firstRow.length < 3) {
        _firstRow.add(image);
      } else {
        _secondRow.add(image);
      }

      /// Add to first row
      // if (image['type'] == 'SMALL_SQUARE' && _firstRowSmall.length != 2) {
      //   _firstRowSmall.add(image);
      // } else if (image['type'] == 'BIG_SQUARE' && _firstRowBig.length != 1) {
      //   _firstRowBig.add(image);
      // } else {
      //   _secondRow.add(image);
      // }
      //   /// Add to second row
      // } else if (image['type'] == 'SMALL_SQUARE' && _secondRow.length < 3) {
      //   _secondRow.add(image);

      //   /// Add to third row
      // } else if (image['type'] == 'SMALL_SQUARE' && _thirdRow.length < 3) {
      //   _thirdRow.add(image);

      //   /// Add to fourth row
      // } else if (image['type'] == 'SMALL_SQUARE' &&
      //     _fourthRowSmall.length != 2) {
      //   _fourthRowSmall.add(image);
      // } else if (image['type'] == 'BIG_SQUARE' && _fourthRowBig.length != 1) {
      //   _fourthRowBig.add(image);
      // }
    }

    // log('First row: $_firstRow');
    // log('Seconrd row: $_secondRow');

    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductImage(
                  src: _firstRow[0]['smallImgUrl'],
                  width: _smallImageWidth,
                ),
                ProductImage(
                  src: _firstRow[1]['smallImgUrl'],
                  width: _smallImageWidth,
                ),
              ],
            ),
            ProductImage(
              src: _firstRow[2]['smallImgUrl'],
              width: _bigImageWidth,
            ),
          ],
        ),
        if (expanded)
          StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            children: [
              for (var image in _secondRow)
                StaggeredGridTile.count(
                  crossAxisCellCount: image['type'] == 'BIG_SQUARE' ? 2 : 1,
                  mainAxisCellCount: image['type'] == 'BIG_SQUARE' ? 2 : 1,
                  child: ProductImage(
                    src: image['smallImgUrl'],
                    width: image['type'] == 'BIG_SQUARE'
                        ? _bigImageWidth
                        : _smallImageWidth,
                  ),
                ),
            ],
          ),
        // if (expanded)
        //   Column(
        //     children: [
        //       Row(
        //         children: _secondRow
        //             .map(
        //               (image) => ProductImage(
        //                 src: image['smallImgUrl'],
        //                 width: _smallImageWidth,
        //               ),
        //             )
        //             .toList(),
        //       ),
        //       Row(
        //         children: _thirdRow
        //             .map(
        //               (image) => ProductImage(
        //                 src: image['smallImgUrl'],
        //                 width: _smallImageWidth,
        //               ),
        //             )
        //             .toList(),
        //       ),
        //       Row(
        //         children: [
        //           ProductImage(
        //             src: _fourthRowBig.first['smallImgUrl'],
        //             width: _bigImageWidth,
        //           ),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: _fourthRowSmall
        //                 .map((image) => ProductImage(
        //                       src: image['smallImgUrl'],
        //                       width: _smallImageWidth,
        //                     ))
        //                 .toList(),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
      ],
    );
  }
}
