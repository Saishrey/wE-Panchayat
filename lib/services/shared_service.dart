import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_response_model.dart';
import '../screens/auth/login.dart';

class SharedService {
  static Future<void> setMPIN(String mpin) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: "MPIN", value: mpin);
  }

  static Future<String?> getMPIN() async {
    final storage = FlutterSecureStorage();

    bool containsKey = await storage.containsKey(key: "MPIN");
    if (containsKey) {
      String? cacheMPIN = await storage.read(key: "MPIN");
      return cacheMPIN;
    }
  }

  static Future<void> deleteMPIN() async {
    final storage = FlutterSecureStorage();

    bool containsKey = await storage.containsKey(key: "MPIN");
    if (containsKey) {
      await storage.delete(key: "MPIN");
    }
  }

  static Future<bool> isLoggedIn() async {
    // var isKeyExist =
    //     await APICacheManager().isAPICacheKeyExist("login_details");
    //
    // return isKeyExist;


    final storage = FlutterSecureStorage();
    // Check if a key exists
    bool containsKey = await storage.containsKey(key: "login_details");
    return containsKey;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    // var isKeyExist =
    //     await APICacheManager().isAPICacheKeyExist("login_details");
    //
    // if (isKeyExist) {
    //   var cacheData = await APICacheManager().getCacheData("login_details");
    //
    //   return loginResponseJson(cacheData.syncData);
    // }

    final storage = FlutterSecureStorage();
    // Check if a key exists
    bool containsKey = await storage.containsKey(key: "login_details");
    if (containsKey) {
      String? cacheData = await storage.read(key: "login_details");
      return loginResponseJson(cacheData!);
    }

  }

  static Future<Map<String, String>?> cookieDetails() async {
    // var isKeyExist =
    // await APICacheManager().isAPICacheKeyExist("cookie_headers");
    //
    // if (isKeyExist) {
    //   var cacheData = await APICacheManager().getCacheData("cookie_headers");
    //
    //   Map<String, dynamic>? dynamicMap = jsonDecode(cacheData.syncData);
    //
    //   Map<String, String>? stringMap = dynamicMap?.map((key, value) => MapEntry(key, value.toString()));
    //
    //   return stringMap;
    // }

    final storage = FlutterSecureStorage();
    // Check if a key exists
    bool containsKey = await storage.containsKey(key: "cookie_headers");

    if (containsKey) {
      String? cacheData = await storage.read(key: "cookie_headers");
      Map<String, dynamic>? dynamicMap = jsonDecode(cacheData!);
      Map<String, String>? stringMap = dynamicMap?.map((key, value) => MapEntry(key, value.toString()));
      return stringMap;
    }

  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    // APICacheDBModel cacheDBModel = APICacheDBModel(
    //     key: "login_details", syncData: jsonEncode(model.toJson()));
    //
    //
    // await APICacheManager().addCacheData(cacheDBModel);


    final storage = FlutterSecureStorage();
    await storage.write(key: "login_details", value: jsonEncode(model.toJson()));

  }

  static Future<void> setCookie(Map<String, String> cookieHeaders) async {
    // APICacheDBModel cacheDBModel = APICacheDBModel(
    //     key: "cookie_headers", syncData: jsonEncode(cookieHeaders));
    //
    // await APICacheManager().addCacheData(cacheDBModel);

    final storage = FlutterSecureStorage();
    await storage.write(key: "cookie_headers", value: jsonEncode(cookieHeaders));
  }

  // Function to delete all shared preferences data
  static Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> logout(BuildContext context) async {
    // await APICacheManager().deleteCache("login_details");
    // await APICacheManager().deleteCache("cookie_headers");

    final storage = FlutterSecureStorage();
    await clearSharedPreferences();
    await storage.deleteAll();


    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }
}
