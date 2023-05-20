
class CountryDataList {
  final List<CountryData> countries;

  CountryDataList({required this.countries});

  factory CountryDataList.fromJson(List<dynamic> parsedJson) {
    List<CountryData> country = <CountryData>[];
    country = parsedJson.map((i) => CountryData.fromJSON(i)).toList();
    return new CountryDataList(countries: country);
  }
}

class CountryData {
  final String countryName;
  final int countryCases;
  final int countryDeaths;
  final String countryRecovered;
  final int todayCases;
  final int todayDeaths;
  final int activeCases;
  final int critCases;
  final int totalTests;

  CountryData(
      {required this.activeCases,
        required this.critCases,
        required this.totalTests,
        required this.todayCases,
        required this.todayDeaths,
        required this.countryName,
        required this.countryCases,
        required this.countryDeaths,
        required this.countryRecovered});

  factory CountryData.fromJSON(Map<String, dynamic> json) {
    return CountryData(
        countryName: json['country'],
        countryCases: json['cases'],
        countryDeaths: json['deaths'],
        countryRecovered: json['recovered'].toString(),
        todayCases: json['todayCases'],
        todayDeaths: json["todayDeaths"],
        activeCases: json['active'],
        critCases: json["critical"],
        totalTests: json["totalTests"]);
  }
}
