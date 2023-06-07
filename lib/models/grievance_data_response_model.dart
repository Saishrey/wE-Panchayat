import 'dart:convert';

GrievanceDataResponseModel grievanceDataResponseModelJson(String str) =>
    GrievanceDataResponseModel.fromJson(json.decode(str));


class GrievanceDataResponseModel {
  int? _statusCode;
  Data? _data;

  GrievanceDataResponseModel({required int statusCode, required Data data}) {
    this._statusCode = statusCode;
    this._data = data;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  GrievanceDataResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    if (this._data != null) {
      data['data'] = this._data?.toJson();
    }
    return data;
  }
}

class Data {
  String? _gid;
  String? _title;
  String? _type;
  String? _body;
  String? _mongoId;
  bool? _isResolved;
  Images? _images;

  Data(
      {required String gid,
        required String title,
        required String type,
        required String body,
        required String mongoId,
        required bool isResolved,
        required Images images}) {
    this._gid = gid;
    this._title = title;
    this._type = type;
    this._body = body;
    this._mongoId = mongoId;
    this._isResolved = isResolved;
    this._images = images;
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
  Images? get images => _images;
  set images(Images? images) => _images = images;

  Data.fromJson(Map<String, dynamic> json) {
    _gid = json['gid'];
    _title = json['title'];
    _type = json['type'];
    _body = json['body'];
    _mongoId = json['mongo_id'];
    _isResolved = json['is_resolved'];
    _images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this._gid;
    data['title'] = this._title;
    data['type'] = this._type;
    data['body'] = this._body;
    data['mongo_id'] = this._mongoId;
    data['is_resolved'] = this._isResolved;
    if (this._images != null) {
      data['images'] = this._images?.toJson();
    }
    return data;
  }
}

class Images {
  ImageData? _img1;
  ImageData? _img2;
  ImageData? _img3;

  Images({ required ImageData img1,  required ImageData img2,  required ImageData img3}) {
    this._img1 = img1;
    this._img2 = img2;
    this._img3 = img3;
  }

  ImageData? get img1 => _img1;
  set img1(ImageData? img1) => _img1 = img1;
  ImageData? get img2 => _img2;
  set img2(ImageData? img2) => _img2 = img2;
  ImageData? get img3 => _img3;
  set img3(ImageData? img3) => _img3 = img3;

  Images.fromJson(Map<String, dynamic> json) {
    _img1 = json['img-1'] != null ? new ImageData.fromJson(json['img-1']) : null;
    _img2 = json['img-2'] != null ? new ImageData.fromJson(json['img-2']) : null;
    _img3 = json['img-3'] != null ? new ImageData.fromJson(json['img-3']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._img1 != null) {
      data['img-1'] = this._img1?.toJson();
    }
    if (this._img2 != null) {
      data['img-2'] = this._img2?.toJson();
    }
    if (this._img3 != null) {
      data['img-3'] = this._img3?.toJson();
    }
    return data;
  }
}

class ImageData {
  String? _type;
  List<int>? _data;

  ImageData({required String type, required List<int> data}) {
    this._type = type;
    this._data = data;
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  List<int>? get data => _data;
  set data(List<int>? data) => _data = data;

  ImageData.fromJson(Map<String, dynamic> json) {
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
