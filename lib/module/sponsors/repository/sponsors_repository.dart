import 'dart:math';

import '../util/grid_generator.dart';
import '../models/sponsor.dart';
import '../api/sponsors_api.dart';

class SponsorsRepository {
  SponsorsRepository({SponsorsAPI? sponsorsAPI})
      : _sponsorsAPI = sponsorsAPI ?? SponsorsAPI();

  final SponsorsAPI _sponsorsAPI;

  Random random = Random();

  Future<List<Sponsor>> getSponsors(int page) async {
    final List<Sponsor> _loadedSponsors = [];

    try {
      final List _rawData = await _sponsorsAPI.fetchSponsors(page);

      for (var sponsor in _rawData) {
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
