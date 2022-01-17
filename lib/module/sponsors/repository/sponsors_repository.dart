import 'dart:math';

import '../util/grid_generator.dart';
import '../models/sponsor.dart';
import '../api/sponsors_api_client.dart';

class SponsorsRepository {
  static Random random = Random();

  static Future<List<Sponsor>> getSponsors(int page) async {
    List<Sponsor> _loadedSponsors = [];
    _loadedSponsors = await SponsorsApiClient.fetchSponsors(page);
    return _loadedSponsors;
  }
}
