import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SponsorsApiClient {
  static Random random = Random();

  static Future<List> fetchSponsors(int page) async {
    // final List<Sponsor> _loadedSponsors = [];
    List _loadedData = [];

    final String url =
        'https://61e2d5ee3050a100176822b4.mockapi.io/api/sponsors?page=$page&limit=3';

    try {
      final _response = await http.get(Uri.parse(url));

      if (_response.statusCode != 200) {
        throw Exception();
      }

      _loadedData = jsonDecode(_response.body) as List;
    } catch (error) {
      rethrow;
    }

    return _loadedData;
  }
}
