import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/sponsor.dart';
import '../cubit/sponsor_cubit.dart';
import './expand_button.dart';
import './product_images.dart';

class SponsorCard extends StatelessWidget {
  const SponsorCard({
    required this.sponsor,
    Key? key,
  }) : super(key: key);

  final Sponsor sponsor;

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

                  /// Show cover image grid (if exists)
                  sponsor.hasImageGrid
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Image.network(
                            sponsor.logo,
                            height: 40,
                          ),
                        )

                      /// Show logo as cover (if grid doesn't exist)
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(
                              sponsor.logo,
                              height: 120,
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),
                  if (sponsor.coverImageGrid != null)
                    ProductImages(
                      expanded: expanded,
                      coverGrid: sponsor.coverImageGrid!,
                      expandedGrids: sponsor.expandedImageGrids ?? [],
                    ),
                ],
              ),
            ),

            /// Only show expand button
            /// If cover image grid exists
            if (sponsor.coverImageGrid != null)
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
