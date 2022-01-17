import 'dart:math';

import '../util/grid_generator.dart';
import '../models/sponsor.dart';
import '../api/sponsors_api_client.dart';

class SponsorsRepository {
  static Random random = Random();

  static Future<List<Sponsor>> getSponsors(int page) async {
    final List<Sponsor> _loadedSponsors = [];

    try {
      final List _data = await SponsorsApiClient.fetchSponsors(page);

      for (var sponsor in _data) {
        // Generate product image grids for each sponsor
        final _grids = GridGenerator.generateGrid(sponsor['productImages']);
        final _coverGrid = _grids['coverGrid'];
        final _expandedGrids = _grids['expandedGrids'];
        final bool _hasGrid = _coverGrid != null;

        // Create new sponsor
        final Sponsor _newSponsor = Sponsor(
          id: random.nextInt(10000),
          name: sponsor['companyName'],
          logo: sponsor['logoImageNoPadding'],
          images: sponsor['productImages'],
          coverImageGrid: _coverGrid,
          expandedImageGrids: _expandedGrids,
          hasImageGrid: _hasGrid,
        );
        _loadedSponsors.add(_newSponsor);
      }
    } catch (error) {
      rethrow;
    }
    return _loadedSponsors;
  }
}
