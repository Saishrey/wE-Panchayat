import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:open_file/open_file.dart';
import 'package:we_panchayat_dev/config.dart';
import 'package:http/http.dart' as http;
import 'package:we_panchayat_dev/models/income_certificate_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../models/login_response_model.dart';

class UpdateEmailAPIService {
  static var client = http.Client();

  static Future<bool> getOtpUpdateEmail() async {
    final url = Uri.http(Config.apiURL, UpdateEmailAPI.getOtpAPI);
    print(url);

    Map<String, String> body = {
      "isUpdate": "true",
    };

    print("COOKIE DETAILS Email update otp");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    print(cookieHeaders);

    var response = await client.post(url, headers: cookieHeaders, body: body);

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
  }


  static Future<bool> verifyOtpUpdateEmail(Map<String, String> body) async {
    final url = Uri.http(Config.apiURL, UpdateEmailAPI.verifyOtpAPI);
    print(url);

    print("COOKIE DETAILS Email update verify otp");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    print(cookieHeaders);

    var response = await client.post(url, headers: cookieHeaders, body: body);

    print(response.body);

    if (response.statusCode == 200) {

      return true;
    }
    return false;
  }

  static Future<http.Response> updateEmail(Map<String, String> body) async {
    final url = Uri.http(Config.apiURL, UpdateEmailAPI.updateEmailAPI);
    print(url);

    print("COOKIE DETAILS Email update");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    print(cookieHeaders);

    var response = await client.post(url, headers: cookieHeaders, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      print("Email updated successfully.");
      await SharedService.updateLoginDetails(loginResponseJson(response.body));
    }
    print("Error updating email.");
    return response;
  }
}