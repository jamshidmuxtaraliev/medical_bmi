import 'globalDataModel.dart';

class GlobalData {
  final String cases;
  final String deaths;
  final String recovered;
  GlobalData({required this.cases, required this.deaths, required this.recovered});

  factory GlobalData.fromJSON(Map<String, dynamic> json) {
    return GlobalData(
        cases: json['cases'].toString(),
        deaths: json['deaths'].toString(),
        recovered: json['recovered'].toString());
  }
}