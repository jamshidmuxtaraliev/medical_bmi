import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()

class NewsModel{
  final int id;
  final String? image;
  final String? title;
  final String? sub_title;
  final String? text;

  NewsModel(this.id, this.image, this.title, this.sub_title, this.text);

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
