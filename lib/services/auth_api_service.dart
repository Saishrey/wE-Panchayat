import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:we_panchayat_dev/config.dart';
import 'package:we_panchayat_dev/models/login_request_model.dart';
import 'package:we_panchayat_dev/models/login_response_model.dart';
import 'package:we_panchayat_dev/models/profile_picture_retrieve.dart';
import 'package:we_panchayat_dev/models/register_request_model.dart';
import 'package:we_panchayat_dev/models/register_response_model.dart';
import 'package:we_panchayat_dev/services/profile_pic_api_service.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';

class APIService {
  static Map<String, String> _headers = {};
  static Map<String, String> _cookies = {};
  static List<String> _cookiesList = [];

  static var client = http.Client();

  static var loginResponse;

  static var profilePicResponse;

  static Future<int> checkSession(BuildContext context) async {
    try {
      final url = Uri.http(Config.apiURL, Config.checkSessionAPI);
      print(url);

      print("COOKIE DETAILS Check Session");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      var response = await client
          .post(url, headers: cookieHeaders)
          .timeout(const Duration(seconds: 5));
      print(response.body);

      if (response.statusCode == 200) {
        print("COOKIE PRESENT");
        return 1;
      }

      print("COOKIE ABSENT");
      return 0;
    } catch (e) {
      print("CONNECTION FAILED");
      return 2;
    }
  }

  static Future<http.Response?> login(LoginRequestModel model) async {
    // 'username':'abc@gmail.com', 'password':'Asdfg@123',
    try {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, Config.loginAPI);
      print(url);
      print("${model.toJson()}");

      // jsonEncode(model.toJson())

      var response = await client
          .post(url, body: model.toJson())
          .timeout(const Duration(seconds: 5));

      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        loginResponse = response;

        updateCookie(response);

        print("Redirect to OTP page");

        await SharedService.setCookie(_headers);

        var jsonResponse = jsonDecode(response.body);

        String mongoId = jsonResponse['mongo_id'] ?? "NA";

        print("MONGOID : $mongoId");

        // print("MONGO ID : $mongoId");
        if (mongoId != "NA") {
          // Map<String, String> body = {
          //   'mongoId' : mongoId,
          // };
          var response = await ProfilePicAPIService.retrieveProfilePic(mongoId);
          if (response.statusCode == 200) {
            print("Profile pic retrieved");
            profilePicResponse = response;
          } else {
            print("Error retrieving profile picture");
          }
        }

        return response;
      }

      print("Failed to log in.");
      return response;
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Future<http.Response> forgotPassword(Map<String, String> body) async {
    // 'username':'abc@gmail.com', 'password':'Asdfg@123',
    // try {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, Config.otpAPI);
      print(url);

      print(body);

      // jsonEncode(model.toJson())

      var response = await client
          .post(url, body: body)
          .timeout(const Duration(seconds: 5));

      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        print("Redirect to OTP page reset password");

        updateCookie(response);

        await SharedService.setCookie(_headers);
      } else if (response.statusCode == 409) {
        var msg = jsonDecode(response.body);
        print("${msg['message']}");
      }

      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<bool> logout(BuildContext context) async {
    try {
      final url = Uri.http(Config.apiURL, Config.logoutAPI);
      print(url);

      print("COOKIE DETAILS Logout");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      var response = await client
          .post(url, headers: cookieHeaders)
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        SharedService.logout(context);
        print("Logged out.");
        return true;
      }
      return false;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }

  static Future<Map?> resendOtp() async {
    try {
      print("RESEND otp");

      // Map<String, String> cookieHeader = getCookieHeader();
      //
      // print(cookieHeader);

      print("COOKIE DETAILS resendOTP");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      final url = Uri.http(Config.apiURL, Config.resendOtpAPI);
      print(url);

      http.Response response = await http
          .post(url, headers: cookieHeaders)
          .timeout(const Duration(seconds: 5));

      // updateCookie(response);

      Map body = json.decode(response.body);

      print("OTP get : ");
      print(body);

      return body;
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Future<http.Response> verifyOtp(Map body) async {
    // try {
      print("Verify otp");

      print(body);

      print("COOKIE DETAILS resendOTP");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      final url = Uri.http(Config.apiURL, Config.verifyOtpAPI);
      print(url);

      http.Response response = await http
          .post(url, body: body, headers: cookieHeaders)
          .timeout(const Duration(seconds: 5));

      // updateCookie(response);

      print("${response.body}");
      if (response.statusCode == 200) {
        print("OTP verified.");

        await SharedService.setLoginDetails(
            loginResponseJson(loginResponse.body));

        if (profilePicResponse != null) {
          File? file = await getProfilePicAsFile(
              profilePictureRetrieveJson(profilePicResponse.body));

          if (file != null) {
            await SharedService.setProfilePicture(file, true);
          }
        }

        loginResponse = null;
        profilePicResponse = null;
        return response;
      }

      print("Incorrect OTP.");
      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<bool> verifyOtpResetPassword(Map body) async {
    try {
      print("Verify otp Reset Password");

      print(body);

      print("COOKIE DETAILS resendOTP");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      final url = Uri.http(Config.apiURL, Config.verifyOtpAPI);
      print(url);

      http.Response response = await http
          .post(url, body: body, headers: cookieHeaders)
          .timeout(const Duration(seconds: 5));

      // updateCookie(response);

      print("${response.body}");
      if (response.statusCode == 200) {
        print("OTP verified.");

        // await SharedService.setLoginDetails(loginResponseJson(loginResponse.body));

        return true;
      }

      print("Incorrect OTP.");
      return false;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }

  static Future<http.Response> updateNewPassword(Map body) async {
    // try {
      print("Update New Password");

      print(body);

      print("COOKIE DETAILS update password");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      final url = Uri.http(Config.apiURL, Config.resetPassAPI);
      print(url);

      http.Response response = await http
          .post(url, body: body, headers: cookieHeaders)
          .timeout(const Duration(seconds: 5));

      print("${response.body}");
      if (response.statusCode == 200) {
        print("Successfully reset password.");
        // SharedService.logout(context);
        return response;
      }

      print("Password reset failed.");
      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return false;
    // }
  }

  static Future<http.Response?> register(RegisterRequestModel model) async {
    try {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, Config.signupAPI);
      print(url);

      print("COOKIE DETAILS Signup");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      print(requestHeaders);

      print(model.toJson());

      var response = await client
          .post(url, body: jsonEncode(model.toJson()), headers: requestHeaders);

      print("${response.body}");

      if (response.statusCode == 200) {
        print("Sign up successful.");

        updateCookie(response);

        await SharedService.setLoginDetails(loginResponseJson(response.body));
        await SharedService.setCookie(_headers);

        return response;
      }

      print("Failed to Sign up.");
      return response;
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Future<http.Response?> blockAccount(Map<String, String> body) async {
    // 'username':'abc@gmail.com', 'password':'Asdfg@123',
    try {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, Config.blockUserAPI);
      print(url);

      var response = await client
          .post(url, body: body)
          .timeout(const Duration(seconds: 5));

      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        print("Account has been blocked.");

        return response;
      }

      print("Failed to block account.");
      return response;
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Map<String, String> getCookieHeader() {
    Map<String, String> cookieHeader = {
      'cookie': _cookiesList[0],
    };

    return cookieHeader;
  }

  static Future<Map> post(String url, dynamic data) async {
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: _headers);

    updateCookie(response);

    return json.decode(response.body);
  }

  static void updateCookie(http.Response response) {
    _headers = {};
    _cookies = {};
    _cookiesList = [];

    String? rawCookie = response.headers['set-cookie'];

    print(rawCookie);

    if (rawCookie != null) {
      var setCookies = rawCookie.split(';');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      _headers['cookie'] = _generateCookieHeader();
    }

    print("HEADERS");
    print(_headers);
    print(jsonEncode(_headers));
    // print(_cookies);
    // print(_cookiesList);
  }

  static void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        _cookies[key] = value;

        _cookiesList.add("$key=$value");
      }
    }
  }

  static String _generateCookieHeader() {
    String cookie = "";

    for (var key in _cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + _cookies[key]!;
    }

    return cookie;
  }

  static Future<File?> getProfilePicAsFile(
      ProfilePictureRetrieveModel? model) async {
    Directory? tempDir = await getExternalStorageDirectory();

    if (model != null) {

      // Get the current time
      DateTime now = DateTime.now();

      // Format the time as a string using DateFormat class from intl package
      String formattedTime = DateFormat('HH:mm:ss').format(now);

      // Create a new file path with the desired file name
      final newFileName = "PROFILE_PIC_$formattedTime";

      List<int>? binaryData;
      binaryData = model.documents?.profilePic?.data;
      return assignFile(newFileName, tempDir?.path, binaryData);
    }
  }

  static Future<File?> assignFile(
      String filename, String? path, List<int>? binaryData) async {
    File? imgFile = await binaryToTempFile(filename, path, binaryData);
    if (imgFile != null) {
      return imgFile;
    }
  }

  static Future<File?> binaryToTempFile(
      String filename, String? path, List<int>? binaryData) async {
    // final directory = await getTemporaryDirectory();
    if (binaryData != null && path != null) {
      final File file;
      // Decode binary data to image
      img.Image? image = img.decodeImage(binaryData);
      // Encode image to JPEG format
      List<int> jpeg = img.encodeJpg(image!);
      file = File('$path/$filename.jpeg');
      print('$filename.jpeg');

      await file.writeAsBytes(jpeg);

      return file;
    }
    return null;
  }
}
