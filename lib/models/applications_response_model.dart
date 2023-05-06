import 'dart:convert';

ApplicationsResponseModel applicationsResponseJson(String str) =>
    ApplicationsResponseModel.fromJson(json.decode(str));

class ApplicationsResponseModel {
  int? _statusCode;
  List<ApplicationsListItem>? _data;
  String? _message;

  ApplicationsResponseModel({required int statusCode, required List<ApplicationsListItem> data, required String message}) {
    this._statusCode = statusCode;
    this._data = data;
    this._message = message;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  List<ApplicationsListItem>? get data => _data;
  set data(List<ApplicationsListItem>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;

  ApplicationsResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = <ApplicationsListItem>[];
      json['data'].forEach((v) {
        _data?.add(new ApplicationsListItem.fromJson(v));
      });
    }
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    if (this._data != null) {
      data['data'] = this._data?.map((v) => v.toJson()).toList();
    }
    data['message'] = this._message;
    return data;
  }
}

class ApplicationsListItem {
  String? _applicationType;
  String? _applicationId;
  String? _applicantsName;
  String? _status;
  String? _date;

  ApplicationsListItem(
      {required String applicationType,
        required String applicationId,
        required String applicantsName,
        required String status,
        required String date}) {
    this._applicationType = applicationType;
    this._applicationId = applicationId;
    this._applicantsName = applicantsName;
    this._status = status;
    this._date = date;
  }

  String? get applicationType => _applicationType;
  set applicationType(String? applicationType) =>
      _applicationType = applicationType;
  String? get applicationId => _applicationId;
  set applicationId(String? applicationId) => _applicationId = applicationId;
  String? get applicantsName => _applicantsName;
  set applicantsName(String? applicantsName) => _applicantsName = applicantsName;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get date => _date;
  set date(String? date) => _date = date;

  ApplicationsListItem.fromJson(Map<String, dynamic> json) {
    _applicationType = json['application_type'];
    _applicationId = json['application_id'];
    _applicantsName = json['applicants_name'];
    _status = json['status'];
    _date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['application_type'] = this._applicationType;
    data['application_id'] = this._applicationId;
    data['applicants_name'] = this._applicantsName;
    data['status'] = this._status;
    data['date'] = this._date;
    return data;
  }
}
