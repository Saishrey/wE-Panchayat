import 'dart:convert';

IncomeCertificateFormResponseModel incomeCertificateFormResponseJson(String str) =>
    IncomeCertificateFormResponseModel.fromJson(json.decode(str));

class IncomeCertificateFormResponseModel {
  int? _statusCode;
  Data? _data;
  String? _message;

  IncomeCertificateFormResponseModel(
      {required int statusCode, required Data data, required String message}) {
    this._statusCode = statusCode;
    this._data = data;
    this._message = message;
  }

  int get statusCode => _statusCode!;
  set statusCode(int statusCode) => _statusCode = statusCode;
  Data get data => _data!;
  set data(Data data) => _data = data;
  String get message => _message!;
  set message(String message) => _message = message;

  IncomeCertificateFormResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    final _data = this._data;
    if (_data != null) {
      data['data'] = _data.toJson();
    }
    data['message'] = this._message;
    return data;
  }
}

class Data {
  String? _refId;
  String? _applicationId;
  String? _mongoId;
  String? _taluka;
  String? _panchayat;
  String? _title;
  String? _applicantsName;
  String? _applicantsAddress;
  String? _phone;
  String? _email;
  String? _parentsName;
  String? _idProof;
  String? _idProofNo;
  String? _dateOfBirth;
  String? _placeOfBirth;
  String? _applicantsRelation;
  String? _occupation;
  String? _annualIncome;
  String? _fromYear;
  String? _toYear;
  String? _maritalStatus;
  String? _toProduceAt;
  String? _purpose;
  String? _status;
  String? _remark;
  bool? _canUpdate;
  Documents? _documents;

  Data(
      {required String refId,
        required String applicationId,
        required String mongoId,
        required String taluka,
        required String panchayat,
        required String title,
        required String applicantsName,
        required String applicantsAddress,
        required String phone,
        required String email,
        required String parentsName,
        required String idProof,
        required String idProofNo,
        required String dateOfBirth,
        required String placeOfBirth,
        required String applicantsRelation,
        required String occupation,
        required String annualIncome,
        required String fromYear,
        required String toYear,
        required String maritalStatus,
        required String toProduceAt,
        required String purpose,
        required String status,
        required String remark,
        required bool canUpdate,
        required Documents documents}) {
    this._refId = refId;
    this._applicationId = applicationId;
    this._mongoId = mongoId;
    this._taluka = taluka;
    this._panchayat = panchayat;
    this._title = title;
    this._applicantsName = applicantsName;
    this._applicantsAddress = applicantsAddress;
    this._phone = phone;
    this._email = email;
    this._parentsName = parentsName;
    this._idProof = idProof;
    this._idProofNo = idProofNo;
    this._dateOfBirth = dateOfBirth;
    this._placeOfBirth = placeOfBirth;
    this._applicantsRelation = applicantsRelation;
    this._occupation = occupation;
    this._annualIncome = annualIncome;
    this._fromYear = fromYear;
    this._toYear = toYear;
    this._maritalStatus = maritalStatus;
    this._toProduceAt = toProduceAt;
    this._purpose = purpose;
    this._status = status;
    this._remark = remark;
    this._canUpdate = canUpdate;
    this._documents = documents;
  }

  String? get refId => _refId;
  set refId(String? refId) => _refId = refId;
  String? get applicationId => _applicationId;
  set applicationId(String? applicationId) => _applicationId = applicationId;
  String? get mongoId => _mongoId;
  set mongoId(String? mongoId) => _mongoId = mongoId;
  String? get taluka => _taluka;
  set taluka(String? taluka) => _taluka = taluka;
  String? get panchayat => _panchayat;
  set panchayat(String? panchayat) => _panchayat = panchayat;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get applicantsName => _applicantsName;
  set applicantsName(String? applicantsName) => _applicantsName = applicantsName;
  String? get applicantsAddress => _applicantsAddress;
  set applicantsAddress(String? applicantsAddress) =>
      _applicantsAddress = applicantsAddress;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get parentsName => _parentsName;
  set parentsName(String? parentsName) => _parentsName = parentsName;
  String? get idProof => _idProof;
  set idProof(String? idProof) => _idProof = idProof;
  String? get idProofNo => _idProofNo;
  set idProofNo(String? idProofNo) => _idProofNo = idProofNo;
  String? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String? dateOfBirth) => _dateOfBirth = dateOfBirth;
  String? get placeOfBirth => _placeOfBirth;
  set placeOfBirth(String? placeOfBirth) => _placeOfBirth = placeOfBirth;
  String? get applicantsRelation => _applicantsRelation;
  set applicantsRelation(String? applicantsRelation) =>
      _applicantsRelation = applicantsRelation;
  String? get occupation => _occupation;
  set occupation(String? occupation) => _occupation = occupation;
  String? get annualIncome => _annualIncome;
  set annualIncome(String? annualIncome) => _annualIncome = annualIncome;
  String? get fromYear => _fromYear;
  set fromYear(String? fromYear) => _fromYear = fromYear;
  String? get toYear => _toYear;
  set toYear(String? toYear) => _toYear = toYear;
  String? get maritalStatus => _maritalStatus;
  set maritalStatus(String? maritalStatus) => _maritalStatus = maritalStatus;
  String? get toProduceAt => _toProduceAt;
  set toProduceAt(String? toProduceAt) => _toProduceAt = toProduceAt;
  String? get purpose => _purpose;
  set purpose(String? purpose) => _purpose = purpose;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get remark => _remark;
  set remark(String? remark) => _remark = remark;
  bool? get canUpdate => _canUpdate;
  set canUpdate(bool? canUpdate) => _canUpdate = canUpdate;
  Documents? get documents => _documents;
  set documents(Documents? documents) => _documents = documents;

  Data.fromJson(Map<String, dynamic> json) {
    _applicationId = json['application_id'];
    _mongoId = json['mongo_id'];
    _taluka = json['taluka'];
    _panchayat = json['panchayat'];
    _title = json['title'];
    _applicantsName = json['applicants_name'];
    _applicantsAddress = json['applicants_address'];
    _phone = json['phone'];
    _email = json['email'];
    _parentsName = json['parents_name'];
    _idProof = json['id_proof'];
    _idProofNo = json['id_proof_no'];
    _dateOfBirth = json['date_of_birth'];
    _placeOfBirth = json['place_of_birth'];
    _applicantsRelation = json['applicants_relation'];
    _occupation = json['occupation'];
    _annualIncome = json['annual_income'];
    _fromYear = json['from_year'];
    _toYear = json['to_year'];
    _maritalStatus = json['marital_status'];
    _toProduceAt = json['to_produce_at'];
    _purpose = json['purpose'];
    _status = json['status'];
    _remark = json['remark'];
    _canUpdate = json['can_update'];
    _documents = json['documents'] != null
        ? new Documents.fromJson(json['documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['application_id'] = this._applicationId;
    data['mongo_id'] = this._mongoId;
    data['taluka'] = this._taluka;
    data['panchayat'] = this._panchayat;
    data['title'] = this._title;
    data['applicants_name'] = this._applicantsName;
    data['applicants_address'] = this._applicantsAddress;
    data['phone'] = this._phone;
    data['email'] = this._email;
    data['parents_name'] = this._parentsName;
    data['id_proof'] = this._idProof;
    data['id_proof_no'] = this._idProofNo;
    data['date_of_birth'] = this._dateOfBirth;
    data['place_of_birth'] = this._placeOfBirth;
    data['applicants_relation'] = this._applicantsRelation;
    data['occupation'] = this._occupation;
    data['annual_income'] = this._annualIncome;
    data['from_year'] = this._fromYear;
    data['to_year'] = this._toYear;
    data['marital_status'] = this._maritalStatus;
    data['to_produce_at'] = this._toProduceAt;
    data['purpose'] = this._purpose;
    data['status'] = this._status;
    data['remark'] = this._remark;
    data['can_update'] = this._canUpdate;
    final _documents = this._documents;
    if (_documents != null) {
      data['documents'] = _documents.toJson();
    }
    return data;
  }
}

class Documents {
  BinaryFile? _rationCard;
  BinaryFile? _aadharCard;
  BinaryFile? _form16;
  BinaryFile? _bankPassbook;
  BinaryFile? _salaryCertificate;
  BinaryFile? _selfDeclaration;
  BinaryFile? _photo;

  Documents(
      {required BinaryFile rationCard,
        required BinaryFile aadharCard,
        required BinaryFile file3,
        required BinaryFile selfDeclaration,
        required BinaryFile photo}) {
    this._rationCard = rationCard;
    this._aadharCard = aadharCard;
    this._form16 = _form16;
    this._bankPassbook = _bankPassbook;
    this._salaryCertificate = _salaryCertificate;
    this._selfDeclaration = selfDeclaration;
    this._photo = photo;
  }

  BinaryFile? get rationCard => _rationCard;
  set rationCard(BinaryFile? rationCard) => _rationCard = rationCard;
  BinaryFile? get aadharCard => _aadharCard;
  set aadharCard(BinaryFile? aadharCard) => _aadharCard = aadharCard;
  BinaryFile? get form16 => _form16;
  set file3(BinaryFile? form16) =>
      _form16 = form16;
  BinaryFile? get bankPassbook => _bankPassbook;
  set bankPassbook(BinaryFile? bankPassbook) =>
      _bankPassbook = bankPassbook;
  BinaryFile? get salaryCertificate => _salaryCertificate;
  set salaryCertificate(BinaryFile? salaryCertificate) =>
      _salaryCertificate = salaryCertificate;
  BinaryFile? get selfDeclaration => _selfDeclaration;
  set selfDeclaration(BinaryFile? selfDeclaration) =>
      _selfDeclaration = selfDeclaration;
  BinaryFile? get photo => _photo;
  set photo(BinaryFile? photo) => _photo = photo;

  Documents.fromJson(Map<String, dynamic> json) {
    _rationCard = json['rationCard'] != null
        ? new BinaryFile.fromJson(json['rationCard'])
        : null;
    _aadharCard = json['aadharCard'] != null
        ? new BinaryFile.fromJson(json['aadharCard'])
        : null;
    _bankPassbook = json['bankPassbook'] != null
        ? new BinaryFile.fromJson(json['bankPassbook'])
        : null;
    _form16 = json['form16'] != null
        ? new BinaryFile.fromJson(json['form16'])
        : null;
    _salaryCertificate = json['salaryCertificate'] != null
        ? new BinaryFile.fromJson(json['salaryCertificate'])
        : null;
    _selfDeclaration = json['selfDeclaration'] != null
        ? new BinaryFile.fromJson(json['selfDeclaration'])
        : null;
    _photo =
    json['photo'] != null ? new BinaryFile.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final _rationCard = this._rationCard;
    if (_rationCard != null) {
      data['rationCard'] = _rationCard.toJson();
    }
    final _aadharCard = this._aadharCard;
    if (_aadharCard != null) {
      data['aadharCard'] = _aadharCard.toJson();
    }
    final _form16 = this._form16;
    if (_form16 != null) {
      data['form16'] = _form16.toJson();
    }
    final _bankPassbook = this._bankPassbook;
    if (_bankPassbook != null) {
      data['bankPassbook'] = _bankPassbook.toJson();
    }
    final _salaryCertificate = this._salaryCertificate;
    if (_salaryCertificate != null) {
      data['salaryCertificate'] = _salaryCertificate.toJson();
    }
    final _selfDeclaration = this._selfDeclaration;
    if (_selfDeclaration != null) {
      data['selfDeclaration'] = _selfDeclaration.toJson();
    }
    final _photo = this._photo;
    if (_photo != null) {
      data['photo'] = _photo.toJson();
    }
    return data;
  }
}

class BinaryFile {
  String? _type;
  List<int>? _data;

  BinaryFile({required String type, required List<int> data}) {
    this._type = type;
    this._data = data;
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  List<int>? get data => _data;
  set data(List<int>? data) => _data = data;

  BinaryFile.fromJson(Map<String, dynamic> json) {
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
