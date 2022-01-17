import 'package:flutter/material.dart';

class Sponsor {
  Sponsor({
    required this.id,
    required this.name,
    required this.logo,
    required this.images,
    this.hasImageGrid = false,
    this.coverImageGrid,
    this.expandedImageGrids,
  });

  final int id;
  final String name;
  final String logo;
  final List images;
  bool hasImageGrid;
  Widget? coverImageGrid;
  List<Widget>? expandedImageGrids;

  List<Object> get props => [id, name, logo, images];
}
