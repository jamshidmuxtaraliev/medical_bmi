// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidApiModel _$CovidApiModelFromJson(Map<String, dynamic> json) =>
    CovidApiModel(
      (json['response'] as List<dynamic>)
          .map((e) => CovidModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CovidApiModelToJson(CovidApiModel instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
