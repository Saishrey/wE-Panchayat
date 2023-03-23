import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:we_panchayat_dev/config.dart';
import 'package:we_panchayat_dev/models/login_request_model.dart';
import 'package:we_panchayat_dev/models/login_response_model.dart';
import 'package:we_panchayat_dev/models/register_request_model.dart';
import 'package:we_panchayat_dev/models/register_response_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';

class APIService {
  static Map<String, String> _headers = {};
  static Map<String, String> _cookies = {};
  static List<String> _cookiesList = [];

  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    // 'username':'abc@gmail.com', 'password':'Asdfg@123',

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, Config.loginAPI);
    print(url);
    print("${model.toJson()}");

    // jsonEncode(model.toJson())

    var response = await client.post(url, body: model.toJson());

    updateCookie(response);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print("Redirect to OTP page");

      await SharedService.setLoginDetails(loginResponseJson(response.body));
      await SharedService.setCookie(_headers);

      getOtp();

      return true;
    }

    print("Failed to log in.");
    return false;
  }

  static Future<bool> logout() async {
    final url = Uri.http(Config.apiURL, Config.logoutAPI);
    print(url);

    print("COOKIE DETAILS");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    print(cookieHeaders);

    var response = await client.post(url, headers: cookieHeaders);

    if (response.statusCode == 200) {
      print("Logged out.");
      return true;
    }
    return false;
  }

  static Future<Map> getOtp() async {
    print("GET otp");

    Map<String, String> cookieHeader = getCookieHeader();

    print(cookieHeader);

    final url = Uri.http(Config.apiURL, Config.otpAPI);
    print(url);

    http.Response response = await http.get(url, headers: _headers);

    // updateCookie(response);

    Map body = json.decode(response.body);

    print("OTP get : ");
    print(body);

    return body;
  }

  static Future<bool> verifyOtp(Map body) async {
    print("Verify otp");

    print(body);

    Map<String, String> cookieHeader = getCookieHeader();

    print(cookieHeader);

    final url = Uri.http(Config.apiURL, Config.otpAPI);
    print(url);

    http.Response response =
        await http.post(url, body: body, headers: _headers);

    // updateCookie(response);

    Map resBody = json.decode(response.body);

    if (response.statusCode == 200) {
      print("OTP verified.");
      print(resBody);

      return true;
    }

    print("Incorrect OTP.");
    return false;
  }

  static Future<bool> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, Config.signupAPI);

    print(model.toJson());

    // Map map = {
    //   "email": "captain@gmail.com",
    //   "password": "Asdfg@123",
    //   "full_name": 'Captain America',
    //   "address": "Brooklyn",
    //   "pincode": "403602",
    //   "phone": "8530129425",
    //   "taluka": "Salcete",
    //   "village": "Colva",
    //   "date_of_birth": "16-07-2001",
    // };

    var response = await client.post(url,
        body: jsonEncode(model.toJson()), headers: requestHeaders);

    print("${response.body}");

    if (response.statusCode == 200) {
      print("Sign up successful.");
      return true;
    }

    print("Failed to Sign up.");
    return false;
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
}
