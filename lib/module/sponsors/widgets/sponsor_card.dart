import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sponsors/module/sponsors/cubit/sponsor_cubit.dart';
import 'package:sponsors/module/sponsors/widgets/expand_button.dart';
import 'package:sponsors/module/sponsors/widgets/product_images.dart';

class SponsorCard extends StatelessWidget {
  const SponsorCard({
    required this.id,
    required this.name,
    required this.logo,
    required this.images,
    Key? key,
  }) : super(key: key);

  final int id;
  final String name;
  final String logo;
  final List images;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SponsorCubit, bool>(
      builder: (context, expanded) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(
                      logo,
                      height: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProductImages(
                    expanded: expanded,
                    images: images,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 20,
              child: ExpandButton(
                onTap: () {
                  expanded
                      ? context.read<SponsorCubit>().collapse()
                      : context.read<SponsorCubit>().expand();
                },
                expanded: expanded,
              ),
            ),
          ],
        );
      },
    );
  }
}
