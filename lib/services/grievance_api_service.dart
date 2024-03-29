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
import 'package:we_panchayat_dev/models/birth_and_death_certificate_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/grievance_retrieve_all_response_model.dart';
import 'package:we_panchayat_dev/models/income_certificate_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../models/login_response_model.dart';

class GrievanceAPIService {
  static var client = http.Client();

  static Future<http.Response> submitGrievance(BuildContext context,
      Map<String, String?> body, Map<String, File> fileMap) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, GrievanceAPI.submitGrievanceAPI);
      print(url);

      print("COOKIE DETAILS Submit Grievance");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      print(requestHeaders);

      print(body);

      var response =
          await client.post(url, body: body, headers: requestHeaders);

      print("${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final gid = responseBody["gid"].toString();

        var imagesResponse =
            await GrievanceAPIService.uploadGrievanceImages(fileMap, gid);

        if(imagesResponse != null ) {
          if (!imagesResponse) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: Failed to upload images"),
              ),
            );
          }
        }
      }

      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<bool> uploadGrievanceImages(
      Map<String, File> fileMap, String grievanceId) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url =
          Uri.http(Config.apiURL, GrievanceAPI.uploadGrievanceImagesAPI);
      print(url);

      var request = http.MultipartRequest('POST', url);
      print("COOKIE DETAILS Upload Grievance Images");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();

      request.headers["Content-Type"] = "multipart/form-data";
      request.headers['cookie'] = cookieHeaders!['cookie']!;

      int count = 0;

      for (var entry in fileMap.entries) {
        count++;
        request.files.add(
          http.MultipartFile(
            entry.key,
            fileMap[entry.key]!.readAsBytes().asStream(),
            fileMap[entry.key]!.lengthSync(),
            filename: path.basename(fileMap[entry.key]!.path),
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
      request.fields['totalFilesCount'] = "$count";
      request.fields['gid'] = grievanceId;
      print(request.files);
      print(request.fields);

      //send request
      var response = await request.send();
      print(response.statusCode);
      print(response.reasonPhrase);

      if (response.statusCode == 200) {
        print("Grievance Images Successfully Submitted.");
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        return true;
      }
      print("Failed to Submit Grievance Images.");
      return false;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<http.Response> retrieveGrievance(String gId) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      String query = "${GrievanceAPI.retrieveGrievanceAPI}/$gId";

      final url = Uri.http(Config.apiURL, query);
      print(url);

      print("COOKIE DETAILS retrieve all grievances");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);

      var response = await client.get(url, headers: requestHeaders);

      // print("${response.body}");

      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<GrievanceRetrieveAllResponseModel>
      retrieveAllGrievances() async {
    // try {
      String? phone = await getPhone();
      print(phone);
      // Map<String, String> body = {
      //   "phone": phone!,
      // };

      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      String query = "${GrievanceAPI.retrieveAllGrievanceAPI}/$phone";

      final url = Uri.http(Config.apiURL, query);
      print(url);

      print("COOKIE DETAILS retrieve all grievances");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);

      var response = await client.get(url, headers: requestHeaders);

      // print("${response.body}");

      return grievanceRetrieveAllResponseModelJson(response.body);
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
