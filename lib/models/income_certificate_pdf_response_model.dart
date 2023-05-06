import 'dart:convert';

IncomeCertificatePDFResponseModel incomeCertificatePDFResponseJson(String str) =>
    IncomeCertificatePDFResponseModel.fromJson(json.decode(str));

class IncomeCertificatePDFResponseModel {
  int? _statusCode;
  String? _message;
  Certificate? _certificate;

  IncomeCertificatePDFResponseModel(
      {required int statusCode, required String message, required Certificate certificate}) {
    this._statusCode = statusCode;
    this._message = message;
    this._certificate = certificate;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  String? get message => _message;
  set message(String? message) => _message = message;
  Certificate? get certificate => _certificate;
  set certificate(Certificate? certificate) => _certificate = certificate;

  IncomeCertificatePDFResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _certificate = json['certificate'] != null
        ? new Certificate.fromJson(json['certificate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    data['message'] = this._message;
    final _certificate = this._certificate;
    if (_certificate != null) {
      data['certificate'] = _certificate.toJson();
    }
    return data;
  }
}

class Certificate {
  String? _type;
  List<int>? _data;

  Certificate({required String type, required List<int> data}) {
    this._type = type;
    this._data = data;
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  List<int>? get data => _data;
  set data(List<int>? data) => _data = data;

  Certificate.fromJson(Map<String, dynamic> json) {
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
