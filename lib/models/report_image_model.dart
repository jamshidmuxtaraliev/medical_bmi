import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'report_image_model.g.dart';

@JsonSerializable()

class ReportImageModel{
  final String name;

  ReportImageModel(this.name);

  factory ReportImageModel.fromJson(Map<String, dynamic> json) => _$ReportImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportImageModelToJson(this);
}
