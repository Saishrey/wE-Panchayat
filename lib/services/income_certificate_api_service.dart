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



class IncomeCertificateAPIService {

  static var client = http.Client();

  static Future<http.Response> saveForm(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.saveFormAPI);
    print(url);

    print("COOKIE DETAILS Income Certificate SAVE FORM");
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


  static Future<bool> uploadFiles(Map<String, File> fileMap, String keyFile3, String applicationId) async {
    fileMap[keyFile3] = fileMap["file3"]!;
    fileMap.remove("file3");

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.uploadDocumentsAPI);
    print(url);
    var request = http.MultipartRequest('POST', url);
    print("COOKIE DETAILS Income Certificate Upload Documents");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();

    request.headers["Content-Type"] = "multipart/form-data";
    request.headers['cookie'] = cookieHeaders!['cookie']!;

    //add files to request
    int count = 1;
    //add photo file to request with explicit MIME type
    request.files.add(http.MultipartFile(
      "photo",
      fileMap["photo"]!.readAsBytes().asStream(),
      fileMap["photo"]!.lengthSync(),
      filename: path.basename(fileMap["photo"]!.path),
      contentType: MediaType('image', 'jpeg'),
    ));

    for (var entry in fileMap.entries) {
        print(entry);
        if(entry.key != "photo") {
          count++;
          request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
        }
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
      print("Income Certificate Form Data Successfully Submitted.");
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      return true;
    }
    print("Failed to Submit Income Certificate Form.");
    return false;
  }

  static Future<bool> updateFiles(Map<String, File> fileMap, String keyFile3, String applicationId) async {
    fileMap[keyFile3] = fileMap["file3"]!;
    fileMap.remove("file3");

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.updateDocumentsAPI);
    print(url);
    var request = http.MultipartRequest('POST', url);
    print("COOKIE DETAILS Income Certificate UPDATE Documents");
    Map<String, String>? cookieHeaders = await SharedService.cookieDetails();

    request.headers["Content-Type"] = "multipart/form-data";
    request.headers['cookie'] = cookieHeaders!['cookie']!;

    //add files to request
    int count = 1;
    //add photo file to request with explicit MIME type
    request.files.add(http.MultipartFile(
      "photo",
      fileMap["photo"]!.readAsBytes().asStream(),
      fileMap["photo"]!.lengthSync(),
      filename: path.basename(fileMap["photo"]!.path),
      contentType: MediaType('image', 'jpeg'),
    ));

    for (var entry in fileMap.entries) {
      print(entry);
      if(entry.key != "photo") {
        count++;
        request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
      }
    }
    request.fields['totalFilesCount'] = "$count" ;
    request.fields['mongoId'] = applicationId;
    print(request.files);
    print(request.fields);

    //send request
    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);

    if (response.statusCode == 200) {
      print("Income Certificate Form Data Successfully Submitted.");
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      return true;
    }
    print("Failed to Submit Income Certificate Form.");
    return false;
  }

  static Future<http.Response> updateForm(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.updateFormAPI);
    print(url);

    print("COOKIE DETAILS Income Certificate UPDATE FORM");
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
  }

  static Future<http.Response> retrieveForm(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.retrieveFormAPI);
    print(url);

    print("COOKIE DETAILS Income Certificate RETRIEVE FORM");
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

  static Future<http.Response> generateCertificatePDF(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.generateCertificatePDFAPI);
    print(url);

    print("COOKIE DETAILS Income Certificate GENERATE FORM PDF");
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
      print("Generated Income Certificate pdf successfully.");

      var pdfResponse = await retrieveCertificatePDF(body);
    }
    else {
      print("Failed to generate Income Certificate pdf.");
    }

    // print(tradeLicenseFormResponseJson(response.body));

    return response;

  }

  static Future<http.Response> retrieveCertificatePDF(Map<String, String> body) async {

    Map<String, String> requestHeaders = {
      // "Content-Type": "application/json",
    };

    final url = Uri.http(Config.apiURL, IncomeCertificateAPI.retrieveCertificatePDFAPI);
    print(url);

    print("COOKIE DETAILS Income Certificate RETRIEVE FORM PDF");
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
      IncomeCertificatePDFResponseModel model = incomeCertificatePDFResponseJson(response.body);

      displayPDF(body['application_id']!, model.certificate?.data);
    }
    return response;
  }

  static void displayPDF(String applicationId, List<int>? data) async {
    Directory? tempDir = await getExternalStorageDirectory();
    String filename = "${applicationId}_income_certificate";
    if(tempDir != null) {
      File? pdfFile = await convertToPDF(filename, tempDir.path, data);
      if(pdfFile != null) {
        print("Income Certificate PDF: ${pdfFile.path}");
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
