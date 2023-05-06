import 'dart:convert';


TradeLicensePDFResponseModel tradeLicensePDFResponseJson(String str) =>
    TradeLicensePDFResponseModel.fromJson(json.decode(str));

class TradeLicensePDFResponseModel {
  int? _statusCode;
  String? _message;
  License? _license;

  TradeLicensePDFResponseModel(
      {required int statusCode, required String message, required License license}) {
    this._statusCode = statusCode;
    this._message = message;
    this._license = license;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  String? get message => _message;
  set message(String? message) => _message = message;
  License? get license => _license;
  set license(License? license) => _license = license;

  TradeLicensePDFResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _license =
    json['license'] != null ? new License.fromJson(json['license']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    data['message'] = this._message;
    if (this._license != null) {
      data['license'] = this._license?.toJson();
    }
    return data;
  }
}

class License {
  String? _type;
  List<int>? _data;

  License({required String type, required List<int> data}) {
    this._type = type;
    this._data = data;
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  List<int>? get data => _data;
  set data(List<int>? data) => _data = data;

  License.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['data'] = this._data;
    return data;
  }
}
