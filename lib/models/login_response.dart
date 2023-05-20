import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()

class LoginResponse{
  final int id;
  final String username;
  final String password;
  final String fullname;
  final String phone_number;
  final String email;
  final String? token;
  final String bio;

  LoginResponse(this.token, this.username, this.password, this.id, this.fullname, this.phone_number, this.email, this.bio,);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
