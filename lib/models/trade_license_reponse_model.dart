import 'dart:convert';

TradeLicenseFormResponseModel tradeLicenseFormResponseJson(String str) =>
    TradeLicenseFormResponseModel.fromJson(json.decode(str));

class TradeLicenseFormResponseModel {
  int? _statusCode;
  Data? _data;
  String? _message;

  TradeLicenseFormResponseModel({required int statusCode, required Data data, required String message}) {
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


  TradeLicenseFormResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  String? _applicationId;
  String? _mongoId;
  String? _signboardId;
  String? _taluka;
  String? _panchayat;
  String? _applicantsName;
  String? _applicantsAddress;
  String? _phone;
  String? _wardNo;
  String? _shopNo;
  String? _ownerName;
  String? _tradeName;
  String? _tradeAddress;
  String? _applicantsRelation;
  String? _tradeType;
  String? _businessNature;
  String? _wasteManagementFacility;
  String? _leasePay;
  String? _tradeArea;
  String? _noOfEmployee;
  bool? _processingFeesPaid;
  bool? _tradeLicenseFeesPaid;
  String? _signboardLocation;
  String? _signboardType;
  String? _signboardContent;
  String? _signboardArea;
  String? _status;
  String? _remark;
  bool? _signboardDetails;
  String? _canUpdate;
  Documents? _documents;

  Data(
      {required String applicationId,
        required String mongoId,
        required String signboardId,
        required String taluka,
        required String panchayat,
        required String applicantsName,
        required String applicantsAddress,
        required String phone,
        required String wardNo,
        required String shopNo,
        required String ownerName,
        required String tradeName,
        required String tradeAddress,
        required String applicantsRelation,
        required String tradeType,
        required String businessNature,
        required String wasteManagementFacility,
        required String leasePay,
        required String tradeArea,
        required String noOfEmployee,
        required bool processingFeesPaid,
        required bool tradeLicenseFeesPaid,
        required String signboardLocation,
        required String signboardType,
        required String signboardContent,
        required String signboardArea,
        required String status,
        required String remark,
        required bool signboardDetails,
        required String canUpdate,
        required Documents documents}) {
    this._applicationId = applicationId;
    this._mongoId = mongoId;
    this._signboardId = signboardId;
    this._taluka = taluka;
    this._panchayat = panchayat;
    this._applicantsName = applicantsName;
    this._applicantsAddress = applicantsAddress;
    this._phone = phone;
    this._wardNo = wardNo;
    this._shopNo = shopNo;
    this._ownerName = ownerName;
    this._tradeName = tradeName;
    this._tradeAddress = tradeAddress;
    this._applicantsRelation = applicantsRelation;
    this._tradeType = tradeType;
    this._businessNature = businessNature;
    this._wasteManagementFacility = wasteManagementFacility;
    this._leasePay = leasePay;
    this._tradeArea = tradeArea;
    this._noOfEmployee = noOfEmployee;
    this._processingFeesPaid = processingFeesPaid;
    this._tradeLicenseFeesPaid = tradeLicenseFeesPaid;
    this._signboardLocation = signboardLocation;
    this._signboardType = signboardType;
    this._signboardContent = signboardContent;
    this._signboardArea = signboardArea;
    this._status = status;
    this._remark = remark;
    this._signboardDetails = signboardDetails;
    this._canUpdate = canUpdate;
    this._documents = documents;
  }

  String? get applicationId => _applicationId;
  set applicationId(String? applicationId) => _applicationId = applicationId;
  String? get mongoId => _mongoId;
  set mongoId(String? mongoId) => _mongoId = mongoId;
  String? get signboardId => _signboardId;
  set signboardId(String? signboardId) => _signboardId = signboardId;
  String? get taluka => _taluka;
  set taluka(String? taluka) => _taluka = taluka;
  String? get panchayat => _panchayat;
  set panchayat(String? panchayat) => _panchayat = panchayat;
  String? get applicantsName => _applicantsName;
  set applicantsName(String? applicantsName) => _applicantsName = applicantsName;
  String? get applicantsAddress => _applicantsAddress;
  set applicantsAddress(String? applicantsAddress) =>
      _applicantsAddress = applicantsAddress;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get wardNo => _wardNo;
  set wardNo(String? wardNo) => _wardNo = wardNo;
  String? get shopNo => _shopNo;
  set shopNo(String? shopNo) => _shopNo = shopNo;
  String? get ownerName => _ownerName;
  set ownerName(String? ownerName) => _ownerName = ownerName;
  String? get tradeName => _tradeName;
  set tradeName(String? tradeName) => _tradeName = tradeName;
  String? get tradeAddress => _tradeAddress;
  set tradeAddress(String? tradeAddress) => _tradeAddress = tradeAddress;
  String? get applicantsRelation => _applicantsRelation;
  set applicantsRelation(String? applicantsRelation) =>
      _applicantsRelation = applicantsRelation;
  String? get tradeType => _tradeType;
  set tradeType(String? tradeType) => _tradeType = tradeType;
  String? get businessNature => _businessNature;
  set businessNature(String? businessNature) => _businessNature = businessNature;
  String? get wasteManagementFacility => _wasteManagementFacility;
  set wasteManagementFacility(String? wasteManagementFacility) =>
      _wasteManagementFacility = wasteManagementFacility;
  String? get leasePay => _leasePay;
  set leasePay(String? leasePay) => _leasePay = leasePay;
  String? get tradeArea => _tradeArea;
  set tradeArea(String? tradeArea) => _tradeArea = tradeArea;
  String? get noOfEmployee => _noOfEmployee;
  set noOfEmployee(String? noOfEmployee) => _noOfEmployee = noOfEmployee;
  bool? get processingFeesPaid => _processingFeesPaid;
  set processingFeesPaid(bool? processingFeesPaid) =>
      _processingFeesPaid = processingFeesPaid;
  bool? get tradeLicenseFeesPaid => _tradeLicenseFeesPaid;
  set tradeLicenseFeesPaid(bool? tradeLicenseFeesPaid) =>
      _tradeLicenseFeesPaid = tradeLicenseFeesPaid;
  String? get signboardLocation => _signboardLocation;
  set signboardLocation(String? signboardLocation) =>
      _signboardLocation = signboardLocation;
  String? get signboardType => _signboardType;
  set signboardType(String? signboardType) => _signboardType = signboardType;
  String? get signboardContent => _signboardContent;
  set signboardContent(String? signboardContent) =>
      _signboardContent = signboardContent;
  String? get signboardArea => _signboardArea;
  set signboardArea(String? signboardArea) => _signboardArea = signboardArea;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get remark => _remark;
  set remark(String? remark) => _remark = remark;
  bool? get signboardDetails => _signboardDetails;
  set signboardDetails(bool? signboardDetails) =>
      _signboardDetails = signboardDetails;
  String? get canUpdate => _canUpdate;
  set canUpdate(String? canUpdate) => _canUpdate = canUpdate;
  Documents? get documents => _documents;
  set documents(Documents? documents) => _documents = documents;

  Data.fromJson(Map<String, dynamic> json) {
    _applicationId = json['application_id'];
    _mongoId = json['mongo_id'];
    _signboardId = json['signboard_id'];
    _taluka = json['taluka'];
    _panchayat = json['panchayat'];
    _applicantsName = json['applicants_name'];
    _applicantsAddress = json['applicants_address'];
    _phone = json['phone'];
    _wardNo = json['ward_no'];
    _shopNo = json['shop_no'];
    _ownerName = json['owner_name'];
    _tradeName = json['trade_name'];
    _tradeAddress = json['trade_address'];
    _applicantsRelation = json['applicants_relation'];
    _tradeType = json['trade_type'];
    _businessNature = json['business_nature'];
    _wasteManagementFacility = json['waste_management_facility'];
    _leasePay = json['lease_pay'];
    _tradeArea = json['trade_area'];
    _noOfEmployee = json['no_of_employee'];
    _processingFeesPaid = json['processing_fees_paid'];
    _tradeLicenseFeesPaid = json['trade_license_fees_paid'];
    _signboardLocation = json['signboard_location'];
    _signboardType = json['signboard_type'];
    _signboardContent = json['signboard_content'];
    _signboardArea = json['signboard_area'];
    _status = json['status'];
    _remark = json['remark'];
    _signboardDetails = json['signboard_details'];
    _canUpdate = json['can_update'];
    _documents = json['documents'] != null
        ? new Documents.fromJson(json['documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['application_id'] = this._applicationId;
    data['mongo_id'] = this._mongoId;
    data['signboard_id'] = this._signboardId;
    data['taluka'] = this._taluka;
    data['panchayat'] = this._panchayat;
    data['applicants_name'] = this._applicantsName;
    data['applicants_address'] = this._applicantsAddress;
    data['phone'] = this._phone;
    data['ward_no'] = this._wardNo;
    data['shop_no'] = this._shopNo;
    data['owner_name'] = this._ownerName;
    data['trade_name'] = this._tradeName;
    data['trade_address'] = this._tradeAddress;
    data['applicants_relation'] = this._applicantsRelation;
    data['trade_type'] = this._tradeType;
    data['business_nature'] = this._businessNature;
    data['waste_management_facility'] = this._wasteManagementFacility;
    data['lease_pay'] = this._leasePay;
    data['trade_area'] = this._tradeArea;
    data['no_of_employee'] = this._noOfEmployee;
    data['processing_fees_paid'] = this._processingFeesPaid;
    data['trade_license_fees_paid'] = this._tradeLicenseFeesPaid;
    data['signboard_location'] = this._signboardLocation;
    data['signboard_type'] = this._signboardType;
    data['signboard_content'] = this._signboardContent;
    data['signboard_area'] = this._signboardArea;
    data['status'] = this._status;
    data['remark'] = this._remark;
    data['signboard_details'] = this._signboardDetails;
    data['can_update'] = this._canUpdate;
    final _documents = this._documents;
    if (_documents != null) {
      data['documents'] = _documents.toJson();
    }
    return data;
  }
}

class Documents {
  BinaryFile? _permissionsGrantedOthersFile;
  BinaryFile? _permissionsGrantedFoodAndDrugs;
  BinaryFile? _permissionsGrantedExcise;
  BinaryFile? _permissionsGrantedPoliceDepartment;
  BinaryFile? _permissionsGrantedCrz;
  BinaryFile? _permissionsGrantedTourism;
  BinaryFile? _permissionsGrantedFireAndBridge;
  BinaryFile? _permissionsGrantedFactoriesAndBoilers;
  BinaryFile? _permissionsGrantedHealthServices;
  BinaryFile? _identityProof;
  BinaryFile? _houseTax;
  BinaryFile? _ownershipDocument;

  Documents(
      {required BinaryFile permissionsGrantedOthersFile,
        required BinaryFile permissionsGrantedFoodAndDrugs,
        required BinaryFile permissionsGrantedExcise,
        required BinaryFile permissionsGrantedPoliceDepartment,
        required BinaryFile permissionsGrantedCrz,
        required BinaryFile permissionsGrantedTourism,
        required BinaryFile permissionsGrantedFireAndBridge,
        required BinaryFile permissionsGrantedFactoriesAndBoilers,
        required BinaryFile permissionsGrantedHealthServices,
        required BinaryFile identityProof,
        required BinaryFile houseTax,
        required BinaryFile ownershipDocument}) {
    this._permissionsGrantedOthersFile = permissionsGrantedOthersFile;
    this._permissionsGrantedFoodAndDrugs = permissionsGrantedFoodAndDrugs;
    this._permissionsGrantedExcise = permissionsGrantedExcise;
    this._permissionsGrantedPoliceDepartment =
        permissionsGrantedPoliceDepartment;
    this._permissionsGrantedCrz = permissionsGrantedCrz;
    this._permissionsGrantedTourism = permissionsGrantedTourism;
    this._permissionsGrantedFireAndBridge = permissionsGrantedFireAndBridge;
    this._permissionsGrantedFactoriesAndBoilers =
        permissionsGrantedFactoriesAndBoilers;
    this._permissionsGrantedHealthServices = permissionsGrantedHealthServices;
    this._identityProof = identityProof;
    this._houseTax = houseTax;
    this._ownershipDocument = ownershipDocument;
  }

  BinaryFile? get permissionsGrantedOthersFile =>
      _permissionsGrantedOthersFile;
  set permissionsGrantedOthersFile(
      BinaryFile? permissionsGrantedOthersFile) =>
      _permissionsGrantedOthersFile = permissionsGrantedOthersFile;
  BinaryFile? get permissionsGrantedFoodAndDrugs =>
      _permissionsGrantedFoodAndDrugs;
  set permissionsGrantedFoodAndDrugs(
      BinaryFile? permissionsGrantedFoodAndDrugs) =>
      _permissionsGrantedFoodAndDrugs = permissionsGrantedFoodAndDrugs;
  BinaryFile? get permissionsGrantedExcise =>
      _permissionsGrantedExcise;
  set permissionsGrantedExcise(
      BinaryFile? permissionsGrantedExcise) =>
      _permissionsGrantedExcise = permissionsGrantedExcise;
  BinaryFile? get permissionsGrantedPoliceDepartment =>
      _permissionsGrantedPoliceDepartment;
  set permissionsGrantedPoliceDepartment(
      BinaryFile? permissionsGrantedPoliceDepartment) =>
      _permissionsGrantedPoliceDepartment = permissionsGrantedPoliceDepartment;
  BinaryFile? get permissionsGrantedCrz =>
      _permissionsGrantedCrz;
  set permissionsGrantedCrz(
      BinaryFile? permissionsGrantedCrz) =>
      _permissionsGrantedCrz = permissionsGrantedCrz;
  BinaryFile? get permissionsGrantedTourism =>
      _permissionsGrantedTourism;
  set permissionsGrantedTourism(
      BinaryFile? permissionsGrantedTourism) =>
      _permissionsGrantedTourism = permissionsGrantedTourism;
  BinaryFile? get permissionsGrantedFireAndBridge =>
      _permissionsGrantedFireAndBridge;
  set permissionsGrantedFireAndBridge(
      BinaryFile? permissionsGrantedFireAndBridge) =>
      _permissionsGrantedFireAndBridge = permissionsGrantedFireAndBridge;
  BinaryFile? get permissionsGrantedFactoriesAndBoilers =>
      _permissionsGrantedFactoriesAndBoilers;
  set permissionsGrantedFactoriesAndBoilers(
      BinaryFile? permissionsGrantedFactoriesAndBoilers) =>
      _permissionsGrantedFactoriesAndBoilers =
          permissionsGrantedFactoriesAndBoilers;
  BinaryFile? get permissionsGrantedHealthServices =>
      _permissionsGrantedHealthServices;
  set permissionsGrantedHealthServices(
      BinaryFile? permissionsGrantedHealthServices) =>
      _permissionsGrantedHealthServices = permissionsGrantedHealthServices;
  BinaryFile? get identityProof => _identityProof;
  set identityProof(BinaryFile? identityProof) =>
      _identityProof = identityProof;
  BinaryFile? get houseTax => _houseTax;
  set houseTax(BinaryFile? houseTax) => _houseTax = houseTax;
  BinaryFile? get ownershipDocument => _ownershipDocument;
  set ownershipDocument(BinaryFile? ownershipDocument) =>
      _ownershipDocument = ownershipDocument;

  Documents.fromJson(Map<String, dynamic> json) {
    _permissionsGrantedOthersFile =
    json['permissionsGranted.others.file'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.others.file'])
        : null;
    _permissionsGrantedFoodAndDrugs =
    json['permissionsGranted.foodAndDrugs'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.foodAndDrugs'])
        : null;
    _permissionsGrantedExcise = json['permissionsGranted.excise'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.excise'])
        : null;
    _permissionsGrantedPoliceDepartment =
    json['permissionsGranted.policeDepartment'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.policeDepartment'])
        : null;
    _permissionsGrantedCrz = json['permissionsGranted.crz'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.crz'])
        : null;
    _permissionsGrantedTourism = json['permissionsGranted.tourism'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.tourism'])
        : null;
    _permissionsGrantedFireAndBridge =
    json['permissionsGranted.fireAndBridge'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.fireAndBridge'])
        : null;
    _permissionsGrantedFactoriesAndBoilers =
    json['permissionsGranted.factoriesAndBoilers'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.factoriesAndBoilers'])
        : null;
    _permissionsGrantedHealthServices =
    json['permissionsGranted.healthServices'] != null
        ? new BinaryFile.fromJson(
        json['permissionsGranted.healthServices'])
        : null;
    _identityProof = json['identityProof'] != null
        ? new BinaryFile.fromJson(json['identityProof'])
        : null;
    _houseTax = json['houseTax'] != null
        ? new BinaryFile.fromJson(json['houseTax'])
        : null;
    _ownershipDocument = json['ownershipDocument'] != null
        ? new BinaryFile.fromJson(json['ownershipDocument'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final _permissionsGrantedOthersFile = this._permissionsGrantedOthersFile;
    if (_permissionsGrantedOthersFile != null) {
      data['permissionsGranted.others.file'] =
          _permissionsGrantedOthersFile.toJson();
    }
    final _permissionsGrantedFoodAndDrugs = this._permissionsGrantedFoodAndDrugs;
    if (_permissionsGrantedFoodAndDrugs != null) {
      data['permissionsGranted.foodAndDrugs'] =
          _permissionsGrantedFoodAndDrugs.toJson();
    }
    final _permissionsGrantedExcise = this._permissionsGrantedExcise;
    if (_permissionsGrantedExcise != null) {
      data['permissionsGranted.excise'] =
          _permissionsGrantedExcise.toJson();
    }
    final _permissionsGrantedPoliceDepartment = this._permissionsGrantedPoliceDepartment;
    if (_permissionsGrantedPoliceDepartment != null) {
      data['permissionsGranted.policeDepartment'] =
          _permissionsGrantedPoliceDepartment.toJson();
    }
    final _permissionsGrantedCrz = this._permissionsGrantedCrz;
    if (_permissionsGrantedCrz != null) {
      data['permissionsGranted.crz'] = _permissionsGrantedCrz.toJson();
    }
    final _permissionsGrantedTourism = this._permissionsGrantedTourism;
    if (_permissionsGrantedTourism != null) {
      data['permissionsGranted.tourism'] =
          _permissionsGrantedTourism.toJson();
    }
    final _permissionsGrantedFireAndBridge = this._permissionsGrantedFireAndBridge;
    if (_permissionsGrantedFireAndBridge != null) {
      data['permissionsGranted.fireAndBridge'] =
          _permissionsGrantedFireAndBridge.toJson();
    }
    final _permissionsGrantedFactoriesAndBoilers = this._permissionsGrantedFactoriesAndBoilers;
    if (_permissionsGrantedFactoriesAndBoilers != null) {
      data['permissionsGranted.factoriesAndBoilers'] =
          _permissionsGrantedFactoriesAndBoilers.toJson();
    }
    final _permissionsGrantedHealthServices = this._permissionsGrantedHealthServices;
    if (_permissionsGrantedHealthServices != null) {
      data['permissionsGranted.healthServices'] =
          _permissionsGrantedHealthServices.toJson();
    }
    final _identityProof = this._identityProof;
    if (_identityProof != null) {
      data['identityProof'] = _identityProof.toJson();
    }
    final _houseTax = this._houseTax;
    if (_houseTax != null) {
      data['houseTax'] = _houseTax.toJson();
    }
    final _ownershipDocument = this._ownershipDocument;
    if (_ownershipDocument != null) {
      data['ownershipDocument'] = _ownershipDocument.toJson();
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

  String get type => _type!;
  set type(String type) => _type = type;
  List<int> get data => _data!;
  set data(List<int> data) => _data = data;

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

