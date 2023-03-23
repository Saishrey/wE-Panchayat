import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
     RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  int? id;
  String? email;
  bool? isValid;
  int? statusCode;
  String? message;

  RegisterResponseModel({this.id, this.email, this.isValid, this.statusCode, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isValid = json['isValid'];
    
    statusCode = json['statusCode'];
    message = json['message'];
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['isValid'] = isValid;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}