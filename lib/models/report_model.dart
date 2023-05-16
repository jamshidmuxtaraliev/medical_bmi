import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()

class ReportModel{
  final int id;
  final String? text;
  final double? datetime;

  ReportModel(this.id, this.text, this.datetime);

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
