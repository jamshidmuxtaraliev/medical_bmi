import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_bmi/models/covid_api_model.dart';
import '../models/countryDataModel.dart';
import '../models/globalDataModel.dart';
import '../models/homeCountryDataModel.dart';

class CovidAPI {
  
  Future<CovidApiModel> getCountry() async {
    String url = "https://covid-193.p.rapidapi.com/statistics?country=Uzbekistan";
    Map<String, String> requestHeaders = {
      'X-RapidAPI-Key': 'dc0f340f6fmsh82d24422cd906f2p1dd7a0jsn9a19ce183714',
      'X-RapidAPI-Host': 'covid-193.p.rapidapi.com',
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '<Your token>'
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      return CovidApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load Post");
    }
  }

  
  Future<HomeStats> getHomeCase() async {
    String url =
        'https://api.apify.com/v2/key-value-stores/QhfG8Kj6tVYMgud6R/records/LATEST?disableRedirect=true';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response);
      return HomeStats.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load Post");
    }
  }
}