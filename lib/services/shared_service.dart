import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/login_response_model.dart';
import '../screens/auth/login.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<Map<String, String>?> cookieDetails() async {
    var isKeyExist =
    await APICacheManager().isAPICacheKeyExist("cookie_headers");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("cookie_headers");

      Map<String, dynamic>? dynamicMap = jsonDecode(cacheData.syncData);

      Map<String, String>? stringMap = dynamicMap?.map((key, value) => MapEntry(key, value.toString()));

      return stringMap;
    }
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "login_details", syncData: jsonEncode(model.toJson()));


    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> setCookie(Map<String, String> cookieHeaders) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "cookie_headers", syncData: jsonEncode(cookieHeaders));

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    await APICacheManager().deleteCache("cookie_headers");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }
}
