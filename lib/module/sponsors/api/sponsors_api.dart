import 'dart:developer' as dev;
import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sponsors/module/sponsors/models/sponsor.dart';

class SponsorsApi {
  late http.Client _httpClient;

  static Random random = Random();

  // static final List<Sponsor> _loadedSponsors = [];

  // static int _page = 0;

  static Future<List<Sponsor>> fetchSponsors(int page) async {
    dev.log('######');
    final List<Sponsor> _loadedSponsors = [];
    dev.log('Loaded sponsers: ${_loadedSponsors.length}');
    dev.log('######');
    final String url =
        'https://61e2d5ee3050a100176822b4.mockapi.io/api/sponsors?page=$page&limit=3';

    try {
      final _response = await http.get(Uri.parse(url));

      final _responseBody = _response.body;
      final _data = jsonDecode(_responseBody);

      for (var sponsor in _data) {
        // dev.log('Sponsor: $sponsor');

        final Sponsor _newSponsor = Sponsor(
          id: random.nextInt(10000),
          name: sponsor['companyName'],
          logo: sponsor['logoImageNoPadding'],
          images: sponsor['productImages'],
        );
        _loadedSponsors.add(_newSponsor);
      }
    } catch (error) {
      dev.log('Error: $error');
    }
    dev.log('New loaded sponsers: ${_loadedSponsors.length}');
    return _loadedSponsors;
  }
}
