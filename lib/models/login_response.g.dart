// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['token'] as String?,
      json['username'] as String,
      json['password'] as String,
      json['id'] as int,
      json['fullname'] as String,
      json['phone_number'] as String,
      json['email'] as String,
      json['bio'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'fullname': instance.fullname,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'token': instance.token,
      'bio': instance.bio,
    };
