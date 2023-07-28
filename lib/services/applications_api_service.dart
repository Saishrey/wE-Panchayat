import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/config.dart';
import 'package:http/http.dart' as http;
import 'package:we_panchayat_dev/models/applications_response_model.dart';
import 'package:we_panchayat_dev/models/login_response_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';

class ApplicationsAPIService {
  static var client = http.Client();

  static Future<ApplicationsResponseModel

  > retrieveAllApplications() async {
    // try{
      String? phone = await getPhone();
      print(phone);
      // Map<String, String> body = {
      //   "phone": phone!,
      // };

      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      String query = "${ApplicationsAPI.allApplicationsAPI}/$phone";

      final url = Uri.http(Config.apiURL, query);
      print(url);

      print("COOKIE DETAILS All applications RETRIEVE DOCUMENTS");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;


      print(requestHeaders);

      var response = await client.get(url, headers: requestHeaders);

      // print("${response.body}");

      return applicationsResponseJson(response.body);
      
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }

  }

  static Future<String?> getPhone() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();

    return loginResponseModel?.phone;
  }
}
