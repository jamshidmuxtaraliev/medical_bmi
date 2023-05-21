// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_have_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportHaveModel _$ReportHaveModelFromJson(Map<String, dynamic> json) =>
    ReportHaveModel(
      json['id'] as int?,
      json['text'] as String?,
      json['report_id'] as int?,
      json['title'] as String?,
      json['user_id'] as int?,
      (json['report_table_imgs'] as List<dynamic>?)
          ?.map((e) => ReportImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportHaveModelToJson(ReportHaveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'report_id': instance.report_id,
      'title': instance.title,
      'text': instance.text,
      'user_id': instance.user_id,
      'report_table_imgs': instance.report_table_imgs,
    };
