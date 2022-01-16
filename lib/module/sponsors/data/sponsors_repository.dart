import '../../../module/sponsors/models/sponsor.dart';
import '../../../module/sponsors/api/sponsors_api.dart';

class SponsorRepository {
  SponsorRepository({SponsorsApi? sponsorApiClient})
      : _sponsorApiClient = sponsorApiClient ?? SponsorsApi();

  final SponsorsApi _sponsorApiClient;

  Future<Sponsor> getSponsors() async {
    // final location = await _weatherApiClient.locationSearch(city);
    // final woeid = location.woeid;
    // final weather = await _weatherApiClient.getWeather(woeid);
    return const Sponsor(
      id: 1,
      name: '',
      images: [],
      logo: '',
    );
    //   // temperature: weather.theTemp,
    //   // location: location.title,
    //   // condition: weather.weatherStateAbbr.toCondition,
    // );
  }
}
