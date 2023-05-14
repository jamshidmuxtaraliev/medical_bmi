import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response.dart';


class PrefUtils {
  static SharedPreferences? _singleton;

  static const PREF_BASE_IMAGE_URL = "base_image_url";
  static const PREF_BASE_FILE_URL = "base_file_url";

  static const UZ_LANG_KEY = "uz";
  static const RU_LANG_KEY = "ru";
  static const DEFAULT_LANG_KEY = UZ_LANG_KEY;

  static const PREF_BDM_ITEMS = "bdm_items";
  static const PREF_SELECTED_BRANCH = "selected_branch";
  static const PREF_FAVORITES = "favorites";
  static const PREF_BASE_URL = "base_url";
  static const PREF_FCM_TOKEN = "fcm_token";
  static const PREF_TOKEN = "token";
  static const PREF_CATEGORY_LIST = "category_list";
  static const PREF_BASKET = "basket";
  static const PREF_USER = "user";
  static const PREF_LANG = "lang";
  static const PREF_SELECTED_CARD_ID = "selected_card_id";
  static const PREF_FIRST_DELETE_COACH = "first_delete_coach";
  static const PREF_SELECTED_WORKER = "selected_workder";
  static const PREF_DAY_NIGHT = "day_night";

  static const PREF_CONNECT = "connected";


  static SharedPreferences? getInstance() {
    return _singleton;
  }

  static initInstance() async {
    _singleton = await SharedPreferences.getInstance();
  }

  static String getBaseImageUrl() {
    return _singleton?.getString(PREF_BASE_IMAGE_URL) ?? "";
  }

  static Future<bool?> setBaseImageUrl(String value) async {
    return _singleton?.setString(PREF_BASE_IMAGE_URL, value);
  }

  static String getBaseFileUrl() {
    return _singleton?.getString(PREF_BASE_FILE_URL) ?? "";
  }

  static Future<bool?> setBaseFileUrl(String value) async {
    return _singleton?.setString(PREF_BASE_FILE_URL, value);
  }

  static String getBaseUrl() {
    return _singleton?.getString(PREF_BASE_URL) ?? "";
  }

  static Future<bool?> setBaseUrl(String value) async {
    return _singleton?.setString(PREF_BASE_URL, value);
  }

  static String getFCMToken() {
    return _singleton?.getString(PREF_FCM_TOKEN) ?? "";
  }

  static Future<bool?> setFCMToken(String value) async {
    return _singleton?.setString(PREF_FCM_TOKEN, value);
  }

  static String getToken() {
    return _singleton?.getString(PREF_TOKEN) ?? "";
  }

  static Future<bool?> setToken(String value) async {
    return _singleton?.setString(PREF_TOKEN, value);
  }

  static LoginResponse? getUser() {
    if (_singleton?.getString(PREF_USER) == null) {
      return null;
    } else {
      return LoginResponse.fromJson(jsonDecode(_singleton?.getString(PREF_USER) ?? ""));
    }
  }

  static Future<bool?> setUser(LoginResponse value) async {
    return _singleton?.setString(PREF_USER, jsonEncode(value.toJson()));
  }

  static String getLang() {
    return _singleton?.getString(PREF_LANG) ?? DEFAULT_LANG_KEY;
  }

  static Future<bool?> setLang(String value) async {
    return _singleton?.setString(PREF_LANG, value);
  }

  static void clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

}
