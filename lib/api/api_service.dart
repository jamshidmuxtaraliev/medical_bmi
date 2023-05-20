import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:medical_bmi/models/covid_api_model.dart';
import '../../utility/app_constant.dart';
import 'package:flutter/foundation.dart';
import '../main.dart';
import '../models/base_model.dart';
import '../models/clinica_location_model.dart';
import '../models/event_model.dart';
import '../models/login_response.dart';
import '../models/news_model.dart';
import '../models/report_model.dart';
import '../utility/event_bus_provider.dart';
import '../utility/pref_utils.dart';

class ApiService {
  final dio = Dio();

  ApiService() {
    dio.options.baseUrl = BASE_URL;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers.addAll({
      'token': PrefUtils.getToken(),
      'mobile': 1,
      'device': Platform.operatingSystem,
      'lang': PrefUtils.getLang(),
      'Authorization': "Bearer ${PrefUtils.getToken()}"
    });
    dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  String wrapError(DioError error) {
    if (kDebugMode) {
      return error.message;
    }
    switch (error.type) {
      case DioErrorType.other:
        return "Tarmoqqa ulanishda muammo!";
      case DioErrorType.cancel:
        return "Unknown error.";
      case DioErrorType.connectTimeout:
        return "Murojat qilish vaqti tugadi!\nTarmoqqa ulanishda muammo!";
      case DioErrorType.receiveTimeout:
        return "Murojat qilish vaqti tugadi!\nTarmoqqa ulanishda muammo!";
      case DioErrorType.sendTimeout:
        return "Murojat qilish vaqti tugadi!\nTarmoqqa ulanishda muammo!";
      case DioErrorType.response:
        return "Ma'lumot kelishida xatolik!";
    }
    return error.message;
  }

  BaseModel wrapResponse(Response response) {
    if (response.statusCode == 200) {
      final data = BaseModel.fromJson(response.data);
      if (data.success) {
        return data;
      } else {
        if (data.error_code == 405) {
          eventBus.fire(EventModel(event: EVENT_LOG_OUT, data: 0));
          // PrefUtils.setToken("");
        }
      }
      return data;
    } else {
      return BaseModel(
        false,
        response.statusMessage ?? "Unknown error ${response.statusCode}",
        -1,
        null,
      );
    }
  }

  Future<LoginResponse?> login(String username, String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("users/login",
          //queryParameters: {"phone": phone}
          data: jsonEncode({"username": username, "password": password}));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return LoginResponse.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<LoginResponse?> updateUser(String username, String password, String fullname, String phoneNumber,
      String email, String bio, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("users/update",
          //queryParameters: {"phone": phone}
          data: jsonEncode({
            "username": username,
            "password": password,
            "fullname": fullname,
            "phone_number": phoneNumber,
            "email": email,
            "bio": bio
          }));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return LoginResponse.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<LoginResponse?> getUser(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("users/getUser",);
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return LoginResponse.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<LoginResponse?> registration(String phone, String typeSend, String fullname, String smsCode,
      String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("registration",
          //queryParameters: {"phone": phone}
          data: jsonEncode({
            "phone": phone,
            "type_send": typeSend,
            "fullname": fullname,
            "sms_code": smsCode,
            "password": password,
          }));
      final baseData = wrapResponse(response);
      if (!baseData.success) {
        return LoginResponse.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<List<NewsModel>> getNews(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("news", queryParameters: {});
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((json) => NewsModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ClinicaLocationModel>> getClinicLOcations(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("clinic", );
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((json) => ClinicaLocationModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ReportModel>> getMyReports(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("report");
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((json) => ReportModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<bool?> sendReport(
      String title, String text, int reportId, String image, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("report/table",
          data: FormData.fromMap({
            "title": title,
            "text": text,
            "report_id": reportId,
            if (image.isNotEmpty)
              "image": await MultipartFile.fromFile(image, filename: image.split('/').last),
          }));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return true;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return false;
  }

}
