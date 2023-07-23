import 'dart:convert';

ProfilePictureRetrieveModel profilePictureRetrieveJson(String str) =>
    ProfilePictureRetrieveModel.fromJson(json.decode(str));

class ProfilePictureRetrieveModel {
  int? _statusCode;
  Documents? _documents;

  ProfilePictureRetrieveModel({required int statusCode, required Documents documents}) {
    this._statusCode = statusCode;
    this._documents = documents;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  Documents? get documents => _documents;
  set documents(Documents? documents) => _documents = documents;

  ProfilePictureRetrieveModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _documents = json['documents'] != null
        ? new Documents.fromJson(json['documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    if (this._documents != null) {
      data['documents'] = this._documents?.toJson();
    }
    return data;
  }
}

class Documents {
  ProfilePic? _profilePic;

  Documents({required ProfilePic profilePic}) {
    this._profilePic = profilePic;
  }

  ProfilePic? get profilePic => _profilePic;
  set profilePic(ProfilePic? profilePic) => _profilePic = profilePic;

  Documents.fromJson(Map<String, dynamic> json) {
    _profilePic = json['profilePic'] != null
        ? new ProfilePic.fromJson(json['profilePic'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._profilePic != null) {
      data['profilePic'] = this._profilePic?.toJson();
    }
    return data;
  }
}

class ProfilePic {
  String? _type;
  List<int>? _data;

  ProfilePic({required String type, required List<int> data}) {
    this._type = type;
    this._data = data;
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  List<int>? get data => _data;
  set data(List<int>? data) => _data = data;

  ProfilePic.fromJson(Map<String, dynamic> json) {
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
