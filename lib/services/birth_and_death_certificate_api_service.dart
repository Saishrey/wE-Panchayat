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
import 'package:we_panchayat_dev/models/income_certificate_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class BirthAndDeathCertificateAPIService {
  static var client = http.Client();

  static Future<http.Response> getBirthCertificate(
      Map<String, String> body) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url =
          Uri.http(Config.apiURL, BirthCertificateAPI.birthCertificateAPI);
      print(url);

      print("COOKIE DETAILS Birth Certificate");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      print(requestHeaders);

      print(body);

      var response =
          await client.post(url, body: body, headers: requestHeaders).timeout(const Duration(seconds: 5));

      // print("${response.body}");

      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<http.Response> getDeathCertificate(
      Map<String, String> body) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url =
      Uri.http(Config.apiURL, DeathCertificateAPI.deathCertificateAPI);
      print(url);

      print("COOKIE DETAILS Death Certificate");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      print(requestHeaders);

      print(body);

      var response = await client.post(url, body: body, headers: requestHeaders).timeout(const Duration(seconds: 5));

      // print("${response.body}");

      return response;
    // } catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static void displayPDF(String name, List<int>? data) async {
    print(data);
    Directory? tempDir = await getExternalStorageDirectory();
    String filename = "${name}_certificate";
    if (tempDir != null) {
      File? pdfFile = await convertToPDF(filename, tempDir.path, data);
      if (pdfFile != null) {
        print("Birth or Death Certificate PDF: ${pdfFile.path}");
        await OpenFile.open(pdfFile.path);
      }
    }
  }

  static Future<File?> convertToPDF(
      String filename, String path, List<int>? binaryData) async {
    // final directory = await getTemporaryDirectory();
    if (binaryData != null) {
      final file = File('$path/$filename.pdf');
      await file.writeAsBytes(binaryData);
      return file;
    }
    return null;
  }
}
