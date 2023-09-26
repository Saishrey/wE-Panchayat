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

class ProfilePicAPIService {
  static var client = http.Client();

  static Future<bool> uploadProfilePic(File profilePic, int userid) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, ProfilePicAPI.uploadPictureAPI);
      print(url);

      var request = http.MultipartRequest('POST', url);
      print("COOKIE DETAILS Profile pic upload");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();

      request.headers["Content-Type"] = "multipart/form-data";
      request.headers['cookie'] = cookieHeaders!['cookie']!;


      request.files.add(
        http.MultipartFile(
          "profilePic",
          profilePic.readAsBytes().asStream(),
          profilePic.lengthSync(),
          filename: path.basename(profilePic.path),
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.fields['totalFilesCount'] = "1";
      request.fields['applicationId'] = "$userid";
      print(request.files);
      print(request.fields);

      //send request
      var response = await request.send();
      print(response.statusCode);
      print(response.reasonPhrase);

      if (response.statusCode == 200) {
        print("Profile pic uploaded successfully.");
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        await SharedService.updateLoginDetails(loginResponseJson(responseBody));
        return true;
      }
      print("Failed to upload profile pic.");
      return false;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return false;
    // }

  }

  static Future<http.Response> retrieveProfilePic(String mongoId) async {

    // try {


      String query = "${ProfilePicAPI.retrievePictureAPI}/$mongoId";

      final url = Uri.http(Config.apiURL, query);
      print(url);

      print("COOKIE DETAILS retrieve profile picture");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);
      Map<String, String> requestHeaders = {
      'cookie' : cookieHeaders!['cookie']!,
      'Device-Info' : cookieHeaders['Device-Info']!,
      };
      // requestHeaders['cookie'] = cookieHeaders!['cookie']!;
      // requestHeaders['Device-Info'] = cookieHeaders['Device-Info']!;


      // var response = await client.get(url);
      // print(response.body);

      print("REQUEST HEADERS: $requestHeaders");

      var response = await client.get(url, headers: requestHeaders);

      print("${response.body}");

      return response;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return null;
    // }



  }

  static Future<bool> updateProfilePic(File profilePic, String mongoId) async {
    // try {
      Map<String, String> requestHeaders = {
        // "Content-Type": "application/json",
      };

      final url = Uri.http(Config.apiURL, ProfilePicAPI.updatePictureAPI);
      print(url);

      var request = http.MultipartRequest('PATCH', url);
      print("COOKIE DETAILS Profile pic update");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();

      request.headers["Content-Type"] = "multipart/form-data";
      request.headers['cookie'] = cookieHeaders!['cookie']!;


      request.files.add(
        http.MultipartFile(
          "profilePic",
          profilePic.readAsBytes().asStream(),
          profilePic.lengthSync(),
          filename: path.basename(profilePic.path),
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.fields['totalFilesCount'] = "1";
      request.fields['mongoId'] = "$mongoId";
      print(request.files);
      print(request.fields);

      //send request
      var response = await request.send();
      print(response.statusCode);
      print(response.reasonPhrase);

      if (response.statusCode == 200) {
        print("Profile pic uploaded successfully.");
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        return true;
      }
      print("Failed to upload profile pic.");
      return false;
    // }
    // catch (e) {
    //   print('Error : $e');
    //   return false;
    // }

  }

  static Future<bool> deleteProfilePic(int userId, String mongoId) async {
    // try {
      final url = Uri.http(Config.apiURL, ProfilePicAPI.deletePictureAPI);
      print(url);

      Map<String, String> body = {
        "applicationId": "$userId",
        "mongoId" : mongoId,
      };

      print(body);

      print("COOKIE DETAILS delete profile pic");
      Map<String, String>? cookieHeaders = await SharedService.cookieDetails();
      print(cookieHeaders);

      var response = await client.delete(url, headers: cookieHeaders, body: body).timeout(const Duration(seconds: 5));
      print(response.body);

      if (response.statusCode == 200) {
        await SharedService.updateLoginDetails(loginResponseJson(response.body));
        print("Profile pic deleted successfully.");
        return true;
      }

      print("Error deleting profile pic");
      return false;
    //
    // } catch (e) {
    //   print("CONNECTION FAILED");
    //   return false;
    // }
  }

}