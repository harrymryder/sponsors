import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sponsors/module/sponsors/cubit/sponsor_cubit.dart';
import 'package:sponsors/module/sponsors/util/grid_generator.dart';
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
    //TODO: Move to sponsors API?
    final _grids = GridGenerator.generateGrid(images);
    final _coverGrid = _grids['coverGrid'];
    final _expandedGrids = _grids['expandedGrids'];
    final bool _hasGrid = _coverGrid != null;

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
                  _hasGrid
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Image.network(
                            logo,
                            height: 40,
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(
                              logo,
                              height: 120,
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),
                  if (_coverGrid != null)
                    ProductImages(
                      expanded: expanded,
                      coverGrid: _coverGrid,
                      expandedGrids: _expandedGrids,
                    ),
                ],
              ),
            ),
            if (_coverGrid != null)
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
