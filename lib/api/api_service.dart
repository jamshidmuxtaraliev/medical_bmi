import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../utility/app_constant.dart';
import 'package:flutter/foundation.dart';
import '../main.dart';
import '../models/base_model.dart';
import '../models/event_model.dart';
import '../models/login_response.dart';
import '../utility/event_bus_provider.dart';
import '../utility/pref_utils.dart';

class ApiService {
  final dio = Dio();
  final BASE_URL = "http://91.213.99.105:3010/api/v1/users/";

  ApiService() {
    dio.options.baseUrl = BASE_URL;
    // dio.options.baseUrl = "http://192.168.1.143:8080/Officebase/hs/BDM/";
    dio.options.headers['content-Type'] = 'application/json';
//    dio.options.headers["Authorization"] = "Bearer ${PrefUtils.getToken()}";
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode("${PrefUtils.getBdmItems()?.mobile_username}:${PrefUtils.getBdmItems()?.mobile_password}"))}';
//     dio.options.headers["Authorization"] = basicAuth;
    dio.options.headers.addAll({
      // 'Authorization': 'Basic ' +
      //     base64Encode(utf8.encode(
      //         '${PrefUtils.getBdmItems()?.mobile_username ?? ""}:${PrefUtils.getBdmItems()?.mobile_password ?? ""}')),
      'token': PrefUtils.getToken(),
      'mobile': 1,
      'device': Platform.operatingSystem,
      'lang': PrefUtils.getLang(),
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
      return BaseModel(false, response.statusMessage ?? "Unknown error ${response.statusCode}", -1, null,);
    }
  }

  Future<LoginResponse?> login(
      String username, String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("login",
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

  Future<bool?> checkPhone(
      String phone, String sendType, String country_code, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("checkPhone",
          data: jsonEncode({"phone": phone, "type_send": sendType, "country_code": country_code}));
      final baseData = wrapResponse(response);
      if (!baseData.success) {
        return baseData.data["isRegistered"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<bool?> resetPassword(String phone, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("recovery_pass", data: jsonEncode({"phone": phone}));
      final baseData = wrapResponse(response);
      if (!baseData.success) {
        return true;
      } else {
        errorStream.sink.add(baseData.message ?? "Error receiving sms code. Try again");
        return false;
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
  }

  Future<LoginResponse?> registration(String phone, String typeSend, String fullname, String sms_code,
      String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("registration",
          //queryParameters: {"phone": phone}
          data: jsonEncode({
            "phone": phone,
            "type_send": typeSend,
            "fullname": fullname,
            "sms_code": sms_code,
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

  Future<LoginResponse?> newPassConfirm(
      String phone, String sms_code, String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("pass_confirm",
          data: jsonEncode({
            "phone": phone,
            "sms_code": sms_code,
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
//
//   Future<List<OfferModel>> getOfferList(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getOffers", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => OfferModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   Future<List<NewsModel>> getNews(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getNews", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => NewsModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   Future<List<RateModel>> getRates(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getRates", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => RateModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   Future<List<BrandModel>> getBrands(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getBrands", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => BrandModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   Future<BrandModel?> getBrandById(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getBrandById", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.data;
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return null;
//   }
//
//   Future<List<RateInfoModel>> getRateById(String rate_id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getRateById", queryParameters: {"rate_id": rate_id});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => RateInfoModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   // myProjects
//   Future<List<ProjectModel>> getMyProjects(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getMyProjects", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => ProjectModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   // myProjects
//   Future<List<TariffModel>> getTariffsByProjectId(String id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getTariffsByProjectId", queryParameters: {"id": id});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => TariffModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   Future<List<PaymentLifeModel>> getPaymentLife(String id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("completepurchase", queryParameters: {"id": id});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => PaymentLifeModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   //buyByTariffId
//   Future<bool?> buyPeriodByTraffic(int tariff_id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("buyPeriodByTraffic", data: jsonEncode({"tariff_id": tariff_id}));
//
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return true;
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return null;
//   }
//
//   //to'lov qilish uchin tarif by project id
//   Future<ProjectModel?> getProjectById(String id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getProjectById", queryParameters: {"id": id});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return ProjectModel.fromJson(baseData.data);
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return null;
//   }
//
//   Future<bool?> makeOrderRate(String productId, String rateId, String comment, String categoriya,
//       String connectedProjectId, String name, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("makeOrderRate",
//           data: jsonEncode({
//             "name": name,
//             "productId": productId,
//             "rateId": rateId,
//             "comment": comment,
//             "categoriya": categoriya,
//             "connectedProjectId": connectedProjectId
//           }));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return true;
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return null;
//   }
//
//   //specail order
//   Future<bool?> specialOrder(String category, String comment, StreamController<String> errorStream) async {
//     try {
//       final response =
//           await dio.post("specialOrder", data: jsonEncode({"category": category, "comment": comment}));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return true;
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return null;
//   }
//
// //map
//   Future<List<MapModel>> getClientsAddresses(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getClientsLocAdr", queryParameters: {});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => MapModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return [];
//   }
//
//   //kartalar ro'yhati
//   Future<List<CreditCardModel>> getCreditCards(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get(
//         "getCreditCards",
//       );
//       var baseData = wrapResponse(response);
//       if (!baseData.error) {
//         if (baseData.data != null) {
//           var list = (baseData.data as List<dynamic>).map((json) => CreditCardModel.fromJson(json)).toList();
//           return list;
//         } else {
//           errorStream.sink.add("data is null");
//         }
//       } else {
//         if (baseData.error_code == 400) {
//           //plastik bo'lmasa, error = true, error_code = 400 kelishiga kelishilgan
//           return [];
//         }
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//
//     return [];
//   }
//
//   //yangi karta qo'shish
//   Future<String?> addNewCard(String cardNumber, String expireYear, String expireMonth, String phone,
//       String cardName, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("newCard",
//           data: jsonEncode({
//             "cardNumber": cardNumber,
//             "expireYear": expireYear,
//             "expireMonth": expireMonth,
//             "phone": phone,
//             "cardName": cardName
//           }));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.data["session"];
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//       return null;
//     }
//     return null;
//   }
//
//   //yangi karta qoshishdagi otp
//   Future<String?> newCardConfirm(
//       String session, String otp, String cardName, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("newCardConfirm",
//           data: jsonEncode({
//             "session": session,
//             "otp": otp,
//             "cardName": cardName,
//           }));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.message ?? "Закончилось";
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   //deleteCard
//   Future<String?> deleteCard(int id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.delete("deleteCard", queryParameters: {"id": id});
//
//       var baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.message;
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error!");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e).replaceAll("isti.uz", "MAINSERVER"));
//     }
//     return null;
//   }
//
//   //transfer
//   Future<int?> transferFromCard(int cardId, double amount, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("transferFromCard",
//           data: jsonEncode({
//             "cardId": cardId,
//             "amount": amount,
//           }));
//
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.data["balance"];
//       } else {
//         if (baseData.error_code == 405) {
//           errorStream.sink.add("Autification error!");
//         }
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   //paymentByProjectId
//   Future<int?> paymentByProjectId(String projectId, double amount, int? day, int? month, int? tariff_id,
//       StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("paymentByProjectId",
//           data: jsonEncode({
//             "projectId": projectId,
//             "amount": amount,
//             "day": day,
//             "month": month,
//             "tariff_id": tariff_id
//           }));
//
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.data["balance"];
//       } else {
//         if (baseData.error_code == 405) {
//           errorStream.sink.add("Autification error!");
//         }
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   //getMyCash
//   Future<double?> getMyAmount(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("getMyAmount");
//
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         double balance = 0.0;
//         (baseData.data["balance"] is int)
//             ? balance = (baseData.data["balance"]).toDouble()
//             : balance = baseData.data["balance"];
//         return balance;
//       } else {
//         if (baseData.error_code == 405) {
//           errorStream.sink.add("Autification error!");
//         }
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   //support
//   Future<bool?> connected(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("connected");
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.data["connected"];
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   Future<ChatModel?> sendMessage(String message, String chat_id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("sendMessageChat",
//           queryParameters: {"chat_id": chat_id}, data: jsonEncode({"message": message}));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return ChatModel.fromJson(baseData.data[0]);
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   Future<String?> sendVoiceMessage(String voice, String chat_id, StreamController<String> errorStream) async {
//     try {
//       String fileName = voice.split('/').last;
//       final response = await dio.post("sendVoiceChat",
//           queryParameters: {"chat_id": chat_id},
//           data: FormData.fromMap({
//             if (voice.isNotEmpty) "voice": await MultipartFile.fromFile(voice, filename: fileName),
//           }));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         // return ChatModel.fromJson(baseData.data);
//         return baseData.data["chat_id"];
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   Future<bool?> sendRequest(String project_id, String title, String comment, int prioritet, String image,
//       String voice, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.post("customerInquiry",
//           data: FormData.fromMap({
//             "security_cod": project_id,
//             "title": title,
//             "comment": comment,
//             "prioritet": prioritet,
//             if (image.isNotEmpty) "img": await MultipartFile.fromFile(image, filename: image.split('/').last),
//             if (voice.isNotEmpty)
//               "voice": await MultipartFile.fromFile(voice, filename: voice.split('/').last),
//           }));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return true;
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return false;
//   }
//
//   Future<List<ChatModel>> getChat(String id, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getChat", queryParameters: {"id": id});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => ChatModel.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return [];
//   }
//
//   Future<UserModel?> getUser(StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getUser",
//           queryParameters: {"fcm_token": PrefUtils.getFCMToken(), "phone": PrefUtils.getUser()?.phone});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return UserModel.fromJson(baseData.data);
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
//
//   Future<List<RequestData>> getRequestList(int status, StreamController<String> errorStream) async {
//     try {
//       final response = await dio.get("getRequestList", queryParameters: {"status": status});
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return (baseData.data as List<dynamic>).map((json) => RequestData.fromJson(json)).toList();
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return [];
//   }
//
//   Future<String?> sendRating(
//       String comment, String chat_id, int rate, StreamController<String> errorStream) async {
//     try {
//       var query = {"chat_id": chat_id};
//       final response = await dio.post("Confirrm",
//           queryParameters: query, data: jsonEncode({"comment": comment, "rate": rate}));
//       final baseData = wrapResponse(response);
//       if (!baseData.error) {
//         return baseData.data["chat_id"];
//       } else {
//         errorStream.sink.add(baseData.message ?? "Error");
//       }
//     } on DioError catch (e) {
//       errorStream.sink.add(wrapError(e));
//     }
//     return null;
//   }
}
