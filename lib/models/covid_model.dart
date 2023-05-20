import 'covid_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_model.g.dart';

@JsonSerializable()
class CovidModel{
  final CovidResponseModel cases;
  final CovidResponseModel deaths;
  final CovidResponseModel tests;
  final String day;

  CovidModel(this.cases, this.deaths, this.tests, this.day);

  factory CovidModel.fromJson(Map<String, dynamic> json) => _$CovidModelFromJson(json);

  Map<String, dynamic> toJson() => _$CovidModelToJson(this);
}