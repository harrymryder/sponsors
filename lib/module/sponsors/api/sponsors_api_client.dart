import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../util/grid_generator.dart';
import '../models/sponsor.dart';

class SponsorsApiClient {
  static Random random = Random();

  static Future<List<Sponsor>> fetchSponsors(int page) async {
    List<Sponsor> _loadedSponsors = [];

    final String url =
        'https://61e2d5ee3050a100176822b4.mockapi.io/api/sponsors?page=$page&limit=3';

    try {
      final _response = await http.get(Uri.parse(url));

      if (_response.statusCode != 200) {
        throw Exception();
      }

      final _data = jsonDecode(_response.body) as List;

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
