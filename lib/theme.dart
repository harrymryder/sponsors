import 'package:flutter/material.dart';

List<BoxShadow> get smallShadow {
  return [
    BoxShadow(
      color: Colors.grey.shade300,
      blurRadius: 1,
      spreadRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];
}
