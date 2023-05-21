import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:medical_bmi/models/report_image_model.dart';

part 'report_have_model.g.dart';

@JsonSerializable()

class ReportHaveModel{
  final int? id;
  final int? report_id;
  final String? title;
  final String? text;
  final int? user_id;
  final List<ReportImageModel>? report_table_imgs;

  ReportHaveModel(this.id, this.text, this.report_id, this.title, this.user_id, this.report_table_imgs, );

  factory ReportHaveModel.fromJson(Map<String, dynamic> json) => _$ReportHaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportHaveModelToJson(this);
}
