import 'covid_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_api_model.g.dart';

@JsonSerializable()
class CovidApiModel{
  final List<CovidModel> response;

  CovidApiModel(this.response);

  factory CovidApiModel.fromJson(Map<String, dynamic> json) => _$CovidApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CovidApiModelToJson(this);
}