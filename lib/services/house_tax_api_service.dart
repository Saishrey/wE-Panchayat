import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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


class HouseTaxAPIService {
  static var client = http.Client();

  static Future<http.Response> getTaxDetails(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, HouseTaxAPI.houseTaxAPI);
    print(url);

    print("COOKIE DETAILS House tax");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    requestHeaders['cookie'] = cookieHeaders!['cookie']!;

    // var response = await client.get(url);
    // print(response.body);

    print(requestHeaders);

    print(body);


    var response = await client.post(url,
        body: body, headers: requestHeaders);

    print("${response.body}");

    return response;
    // print("${response.runtimeType}");
    //
    // if (response.statusCode == 200) {
    //   print("Trade License Form Data Successfully Submitted.");
    //
    //   return true;
    // }
    //
    // print("Failed to Submit Trade License Form.");
    // return false;
  }
}