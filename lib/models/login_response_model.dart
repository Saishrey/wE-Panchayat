import 'dart:convert';

import 'package:intl/intl.dart';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  int? id;
  String? fullname;
  String? address;
  String? taluka;
  String? village;
  String? pincode;
  String? dateofbirth;
  String? phone;
  String? gender;
  String? mongoId;
  String? email;
  String? password;
  int? statusCode;
  String? message;

  LoginResponseModel({this.id, this.fullname, this.address, this.taluka, this.village, this.pincode, this.dateofbirth, this.phone, this.email, this.password, this.statusCode, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['full_name'];
    address = json['address'];
    taluka = json['taluka'];
    village = json['village'];
    pincode = json['pincode'];
    dateofbirth = json['date_of_birth'];
    phone = json['phone'];
    gender = json['gender'];
    mongoId = json['mongo_id'];
    email = json['email'];
    password = json['password'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullname;
    data['address'] = address;
    data['taluka'] = taluka;
    data['village'] = village;
    data['pincode'] = pincode;
    data['date_of_birth'] = dateofbirth;
    data['phone'] = phone;
    data['gender'] = gender;
    data['email'] = email;
    data['mongo_id'] = mongoId;
    data['password'] = password;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}