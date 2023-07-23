import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/models/profile_picture_retrieve.dart';
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

  static Future<void> setProfilePicture(File? profilePic) async {

    final storage = FlutterSecureStorage();
    await storage.write(key: "profile_picture", value: profilePic?.path);

  }

  static Future<File?> getProfilePicture() async {
        try {
      // Get the secure storage instance
      final secureStorage = FlutterSecureStorage();

      // Retrieve the file path from secure storage
      final filePath = await secureStorage.read(key: 'profile_picture');

      if (filePath != null) {
        return File(filePath);
      } else {
        print('File path not found in secure storage.');
        return null;
      }
    } catch (e) {
      print('Error while retrieving the file: $e');
      return null;
    }

  }

  static Future<void> deleteProfilePicture() async {
    try {
      // Get the secure storage instance
      final secureStorage = FlutterSecureStorage();

      // Retrieve the file path from secure storage
      final filePath = await secureStorage.read(key: 'profile_picture');

      if (filePath != null) {
        await deleteFile(filePath);
        await secureStorage.delete(key: "profile_picture");
        print('File deleted successfully.');
      } else {
        print('File path not found in secure storage.');
        return null;
      }
    } catch (e) {
      print('Error deleting the file: $e');
    }
  }

  static Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Error deleting file: $e');
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

  static Future<void> updateLoginDetails(LoginResponseModel model) async {
    // APICacheDBModel cacheDBModel = APICacheDBModel(
    //     key: "login_details", syncData: jsonEncode(model.toJson()));
    //
    //
    // await APICacheManager().addCacheData(cacheDBModel);


    final storage = FlutterSecureStorage();
    await storage.delete(key: "login_details");
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
