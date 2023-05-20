// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidResponseModel _$CovidResponseModelFromJson(Map<String, dynamic> json) =>
    CovidResponseModel(
      (json['total'] as num).toDouble(),
      (json['recovered'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CovidResponseModelToJson(CovidResponseModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'recovered': instance.recovered,
    };
