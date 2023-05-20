// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidModel _$CovidModelFromJson(Map<String, dynamic> json) => CovidModel(
      CovidResponseModel.fromJson(json['cases'] as Map<String, dynamic>),
      CovidResponseModel.fromJson(json['deaths'] as Map<String, dynamic>),
      CovidResponseModel.fromJson(json['tests'] as Map<String, dynamic>),
      json['day'] as String,
    );

Map<String, dynamic> _$CovidModelToJson(CovidModel instance) =>
    <String, dynamic>{
      'cases': instance.cases,
      'deaths': instance.deaths,
      'tests': instance.tests,
      'day': instance.day,
    };
