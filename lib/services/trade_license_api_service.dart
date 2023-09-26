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
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, TradeLicenseAPI.saveFormAPI);
      print(url);

      print("COOKIE DETAILS Trade License SAVE FORM");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);

      print(body);


      var response = await client.post(url,
          body: body, headers: requestHeaders);

      print("${response.body}");

      return response;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<bool> deleteForm(String applicationId) async {
    // try {
      String query = "${TradeLicenseAPI.deleteFormAPI}/$applicationId";

      final url = Uri.http(Config.apiURL, query);

      print(url);

      print("COOKIE DETAILS Trade License DELETE FORM");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();


      var response = await client.delete(url, headers: cookieHeaders).timeout(const Duration(seconds: 5));

      print("${response.body}");

      return response.statusCode == 200;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return false;
    // }
  }


  static Future<bool> uploadFiles(Map<String, File> fileMap, String applicationId) async {
    // try {
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
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return false;
    // }

  }

  static Future<http.Response> updateForm(Map<String, String> body) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, TradeLicenseAPI.updateFormAPI);
      print(url);

      print("COOKIE DETAILS Trade License UPDATE FORM");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);

      print(body);


      var response = await client.patch(url,
          body: body, headers: requestHeaders);

      print("${response.body}");

      return response;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return null;
    // }
  }

  static Future<bool> updateFiles(Map<String, File> fileMap, String mongoId) async {
    // try {
      final url = Uri.http(Config.apiURL, TradeLicenseAPI.updateDocumentsAPI);
      print(url);
      var request = http.MultipartRequest('PATCH', url);

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
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return false;
    // }

  }

  static Future<http.Response> retrieveForm(String applicationId) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      String query = "${TradeLicenseAPI.retrieveFormAPI}/$applicationId";

      final url = Uri.http(Config.apiURL, query);
      print(url);

      print("COOKIE DETAILS Trade License RETRIEVE FORM");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);


      var response = await client.get(url, headers: requestHeaders);

      print("${jsonDecode(response.body)['data']}");


      return response;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return null;
    // }


  }

  static Future<http.Response> generateLicensePDF(Map<String, String> body) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, TradeLicenseAPI.generateLicensePDFAPI);
      print(url);

      print("COOKIE DETAILS Trade License GENERATE FORM PDF");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);

      print(body);


      var response = await client.post(url,
          body: body, headers: requestHeaders).timeout(const Duration(seconds: 5));

      print(response.body);

      if(response.statusCode == 200) {
        print("Generated trade license pdf successfully.");

        await retrieveLicensePDF(body);
      }
      else {
        print("Failed to generate trade license pdf.");
      }

      // print(tradeLicenseFormResponseJson(response.body));

      return response;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return null;
    // }


  }

  static Future<http.Response> retrieveLicensePDF(Map<String, String> body) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      String query = "${TradeLicenseAPI.retrieveLicensePDFAPI}/${body["application_id"]}";

      final url = Uri.http(Config.apiURL, query);
      print(url);

      print("COOKIE DETAILS Trade License GENERATE FORM PDF");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;

      // var response = await client.get(url);
      // print(response.body);

      print(requestHeaders);



      var response = await client.get(url,
          headers: requestHeaders);

      // print(response.body);

      if(response.statusCode == 200) {
        TradeLicensePDFResponseModel model = tradeLicensePDFResponseJson(response.body);

        displayPDF(body['application_id']!, model.license?.data);
      }
      return response;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return null;
    // }

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
