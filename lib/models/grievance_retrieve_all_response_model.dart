import 'dart:convert';

GrievanceRetrieveAllResponseModel grievanceRetrieveAllResponseModelJson(String str) =>
    GrievanceRetrieveAllResponseModel.fromJson(json.decode(str));

class GrievanceRetrieveAllResponseModel {
  int? _statusCode;
  List<GrievancesListItem>? _data;
  String? _message;

  GrievanceRetrieveAllResponseModel(
      {required int statusCode, required List<GrievancesListItem> data, required String message}) {
    this._statusCode = statusCode;
    this._data = data;
    this._message = message;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  List<GrievancesListItem>? get data => _data;
  set data(List<GrievancesListItem>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;

  GrievanceRetrieveAllResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = <GrievancesListItem>[];
      json['data'].forEach((v) {
        _data?.add(new GrievancesListItem.fromJson(v));
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

class GrievancesListItem {
  String? _gid;
  String? _title;
  String? _type;
  String? _body;
  String? _mongoId;
  bool? _isResolved;

  GrievancesListItem(
      {required String gid,
        required String title,
        required String type,
        required String body,
        required String mongoId,
        required bool isResolved}) {
    this._title = title;
    this._type = type;
    this._body = body;
    this._mongoId = mongoId;
    this._isResolved = isResolved;
  }

  String? get gid => _gid;
  set gid(String? gid) => _gid = gid;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get body => _body;
  set body(String? body) => _body = body;
  String? get mongoId => _mongoId;
  set mongoId(String? mongoId) => _mongoId = mongoId;
  bool? get isResolved => _isResolved;
  set isResolved(bool? isResolved) => _isResolved = isResolved;

  GrievancesListItem.fromJson(Map<String, dynamic> json) {
    _gid = json['gid'];
    _title = json['title'];
    _type = json['type'];
    _body = json['body'];
    _mongoId = json['mongo_id'];
    _isResolved = json['is_resolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this._gid;
    data['title'] = this._title;
    data['type'] = this._type;
    data['body'] = this._body;
    data['mongo_id'] = this._mongoId;
    data['is_resolved'] = this._isResolved;
    return data;
  }
}
