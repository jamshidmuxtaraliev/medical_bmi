import 'package:json_annotation/json_annotation.dart';

part 'clinica_location_model.g.dart';

@JsonSerializable()
class ClinicaLocationModel{
  final int id;
  final String name;
  final String image;
  final String lat;
  final String long;
  final String? text;

  ClinicaLocationModel(this.id, this.name, this.image, this.lat, this.long, this.text);

  factory ClinicaLocationModel.fromJson(Map<String, dynamic> json) => _$ClinicaLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicaLocationModelToJson(this);
}