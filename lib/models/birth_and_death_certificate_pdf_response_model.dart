import 'dart:convert';

BirthAndDeathCertificatePDFResponseModel birthAndDeathCertificatePDFResponseJson(String str) =>
    BirthAndDeathCertificatePDFResponseModel.fromJson(json.decode(str));

class BirthAndDeathCertificatePDFResponseModel {
  int? _statusCode;
  Certificate? _certificate;

  BirthAndDeathCertificatePDFResponseModel(
      {required int statusCode, required Certificate certificate}) {
    this._statusCode = statusCode;
    this._certificate = certificate;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  Certificate? get certificate => _certificate;
  set certificate(Certificate? certificate) => _certificate = certificate;

  BirthAndDeathCertificatePDFResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _certificate = json['data'] != null
        ? new Certificate.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    final _certificate = this._certificate;
    if (_certificate != null) {
      data['data'] = _certificate.toJson();
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
