import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:we_panchayat_dev/config.dart';
import 'package:http/http.dart' as http;
import 'package:we_panchayat_dev/models/trade_license_pdf_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import 'package:path_provider/path_provider.dart';



class TradeLicenseAPIService {

  static var client = http.Client();

  static Future<http.Response> saveForm(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, TradeLicenseAPI.saveFormAPI);
    print(url);

    print("COOKIE DETAILS Trade License SAVE FORM");
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


  static Future<bool> uploadFiles(Map<String, File> fileMap, String applicationId) async {
    final url = Uri.http(Config.apiURL, TradeLicenseAPI.uploadDocumentsAPI);
    print(url);
    var request = http.MultipartRequest('POST', url);

    print("COOKIE DETAILS Trade License Upload Documents");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    request.headers["Content-Type"] = "multipart/form-data";
    request.headers['cookie'] = cookieHeaders!['cookie']!;

    //add files to request
    int count = 0;
    for (var entry in fileMap.entries) {
        print(entry);
        count++;
        request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
    }
    request.fields['totalFilesCount'] = "$count" ;
    request.fields['applicationId'] = applicationId;
    print(request.files);
    print(request.fields);

    //send request
    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);

    if (response.statusCode == 200) {
      print("Trade License Form Data Successfully Submitted.");
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      return true;
    }
    print("Failed to Submit Trade License Form.");
    return false;
  }

  static Future<http.Response> updateForm(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, TradeLicenseAPI.updateFormAPI);
    print(url);

    print("COOKIE DETAILS Trade License UPDATE FORM");
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

  static Future<bool> updateFiles(Map<String, File> fileMap, String mongoId) async {
    final url = Uri.http(Config.apiURL, TradeLicenseAPI.updateDocumentsAPI);
    print(url);
    var request = http.MultipartRequest('POST', url);

    print("COOKIE DETAILS Trade License UPDATE Documents");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    request.headers["Content-Type"] = "multipart/form-data";
    request.headers['cookie'] = cookieHeaders!['cookie']!;

    //add files to request
    int count = 0;
    for (var entry in fileMap.entries) {
      print(entry);
      count++;
      request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
    }
    request.fields['totalFilesCount'] = "$count" ;
    request.fields['mongoId'] = mongoId;
    print(request.files);
    print(request.fields);

    //send request
    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);

    if (response.statusCode == 200) {
      print("Trade License Form Data Successfully UPDATED.");
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      return true;
    }
    print("Failed to UPDATE Trade License Form.");
    return false;
  }

  static Future<http.Response> retrieveForm(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, TradeLicenseAPI.retrieveFormAPI);
    print(url);

    print("COOKIE DETAILS Trade License RETRIEVE FORM");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    requestHeaders['cookie'] = cookieHeaders!['cookie']!;

    // var response = await client.get(url);
    // print(response.body);

    print(requestHeaders);

    print(body);

    var response = await client.post(url,
        body: body, headers: requestHeaders);

    print("${jsonDecode(response.body)['data']}");

    // print(tradeLicenseFormResponseJson(response.body));

    return response;

  }

  static Future<http.Response> generateLicensePDF(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, TradeLicenseAPI.generateLicensePDFAPI);
    print(url);

    print("COOKIE DETAILS Trade License GENERATE FORM PDF");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    requestHeaders['cookie'] = cookieHeaders!['cookie']!;

    // var response = await client.get(url);
    // print(response.body);

    print(requestHeaders);

    print(body);


    var response = await client.post(url,
        body: body, headers: requestHeaders);

    print(response.body);

    if(response.statusCode == 200) {
      print("Generated trade license pdf successfully.");

      var pdfResponse = await retrieveLicensePDF(body);
    }
    else {
      print("Failed to generate trade license pdf.");
    }

    // print(tradeLicenseFormResponseJson(response.body));

    return response;

  }

  static Future<http.Response> retrieveLicensePDF(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, TradeLicenseAPI.retrieveLicensePDFAPI);
    print(url);

    print("COOKIE DETAILS Trade License GENERATE FORM PDF");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
    requestHeaders['cookie'] = cookieHeaders!['cookie']!;

    // var response = await client.get(url);
    // print(response.body);

    print(requestHeaders);

    print(body);


    var response = await client.post(url,
        body: body, headers: requestHeaders);

    // print(response.body);

    if(response.statusCode == 200) {
      TradeLicensePDFResponseModel model = tradeLicensePDFResponseJson(response.body);

      displayPDF(body['application_id']!, model.license?.data);
    }
    return response;
  }

  static void displayPDF(String applicationId, List<int>? data) async {
    Directory? tempDir = await getExternalStorageDirectory();
    String filename = "${applicationId}_trade_license";
    if(tempDir != null) {
      File? pdfFile = await convertToPDF(filename, tempDir.path, data);
      if(pdfFile != null) {
        print("Trade license PDF: ${pdfFile.path}");
        await OpenFile.open(pdfFile.path);
      }
    }
  }

  static Future<File?> convertToPDF(String filename, String path, List<int>? binaryData) async {
    // final directory = await getTemporaryDirectory();
    if (binaryData != null) {
      final file = File('$path/$filename.pdf');
      await file.writeAsBytes(binaryData);
      return file;
    }
    return null;
  }


}
