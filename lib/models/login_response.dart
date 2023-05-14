import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()

class LoginResponse{
  final String? token;
  final String? username;
  final String? password;
  final int? id;

  LoginResponse(this.token, this.username, this.password, this.id,);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
