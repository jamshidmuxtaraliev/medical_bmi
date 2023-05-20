// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinica_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicaLocationModel _$ClinicaLocationModelFromJson(
        Map<String, dynamic> json) =>
    ClinicaLocationModel(
      json['id'] as int,
      json['name'] as String,
      json['image'] as String,
      json['lat'] as String,
      json['long'] as String,
      json['text'] as String?,
    );

Map<String, dynamic> _$ClinicaLocationModelToJson(
        ClinicaLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'lat': instance.lat,
      'long': instance.long,
      'text': instance.text,
    };
