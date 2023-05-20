import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'covid_response_model.g.dart';

@JsonSerializable()
class CovidResponseModel{
  final double total;
  final double? recovered;
  
  CovidResponseModel(this.total, this.recovered);

  factory CovidResponseModel.fromJson(Map<String, dynamic> json) => _$CovidResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CovidResponseModelToJson(this);
}
