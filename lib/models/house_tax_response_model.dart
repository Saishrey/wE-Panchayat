import 'dart:convert';

HouseTaxResponseModel houseTaxResponseJson(String str) =>
    HouseTaxResponseModel.fromJson(json.decode(str));

class HouseTaxResponseModel {
  int? _statusCode;
  Data? _data;
  String? _message;

  HouseTaxResponseModel({required int statusCode, required Data data, required String message}) {
    this._statusCode = statusCode;
    this._data = data;
    this._message = message;
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  Data? get data => _data;
  set data(Data? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;

  HouseTaxResponseModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this._statusCode;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['message'] = this._message;
    return data;
  }
}

class Data {
  String? _panchayat;
  String? _revenueVillage;
  String? _ownerName;
  String? _houseNo;
  String? _address;
  String? _occupierName;
  String? _financialYear;
  String? _houseNoticeFeeDa;
  String? _houseWarrantFeeDa;
  String? _houseArrearsDa;
  String? _housePenaltyDa;
  String? _houseCurrentDa;
  String? _houseNoticeFeeCa;
  String? _houseWarrantFeeCa;
  String? _houseArrearsCa;
  String? _housePenaltyCa;
  String? _houseCurrentCa;
  String? _garbageArrearsDa;
  String? _garbageCurrentDa;
  String? _garbageArrearsCa;
  String? _garbageCurrentCa;
  bool? _paid;
  int? _totalHouseTax;
  int? _totalGarbageTax;
  int? _amountPayable;

  Data(
      {required String panchayat,
        required String revenueVillage,
        required String ownerName,
        required String houseNo,
        required String address,
        required String occupierName,
        required String financialYear,
        required String houseNoticeFeeDa,
        required String houseWarrantFeeDa,
        required String houseArrearsDa,
        required String housePenaltyDa,
        required String houseCurrentDa,
        required String houseNoticeFeeCa,
        required String houseWarrantFeeCa,
        required String houseArrearsCa,
        required String housePenaltyCa,
        required String houseCurrentCa,
        required String garbageArrearsDa,
        required String garbageCurrentDa,
        required String garbageArrearsCa,
        required String garbageCurrentCa,
        required bool paid,
        required int totalHouseTax,
        required int totalGarbageTax,
        required int amountPayable}) {
    this._panchayat = panchayat;
    this._revenueVillage = revenueVillage;
    this._ownerName = ownerName;
    this._houseNo = houseNo;
    this._address = address;
    this._occupierName = occupierName;
    this._financialYear = financialYear;
    this._houseNoticeFeeDa = houseNoticeFeeDa;
    this._houseWarrantFeeDa = houseWarrantFeeDa;
    this._houseArrearsDa = houseArrearsDa;
    this._housePenaltyDa = housePenaltyDa;
    this._houseCurrentDa = houseCurrentDa;
    this._houseNoticeFeeCa = houseNoticeFeeCa;
    this._houseWarrantFeeCa = houseWarrantFeeCa;
    this._houseArrearsCa = houseArrearsCa;
    this._housePenaltyCa = housePenaltyCa;
    this._houseCurrentCa = houseCurrentCa;
    this._garbageArrearsDa = garbageArrearsDa;
    this._garbageCurrentDa = garbageCurrentDa;
    this._garbageArrearsCa = garbageArrearsCa;
    this._garbageCurrentCa = garbageCurrentCa;
    this._paid = paid;
    this._totalHouseTax = totalHouseTax;
    this._totalGarbageTax = totalGarbageTax;
    this._amountPayable = amountPayable;
  }

  String? get panchayat => _panchayat;
  set panchayat(String? panchayat) => _panchayat = panchayat;
  String? get revenueVillage => _revenueVillage;
  set revenueVillage(String? revenueVillage) => _revenueVillage = revenueVillage;
  String? get ownerName => _ownerName;
  set ownerName(String? ownerName) => _ownerName = ownerName;
  String? get houseNo => _houseNo;
  set houseNo(String? houseNo) => _houseNo = houseNo;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get occupierName => _occupierName;
  set occupierName(String? occupierName) => _occupierName = occupierName;
  String? get financialYear => _financialYear;
  set financialYear(String? financialYear) => _financialYear = financialYear;
  String? get houseNoticeFeeDa => _houseNoticeFeeDa;
  set houseNoticeFeeDa(String? houseNoticeFeeDa) =>
      _houseNoticeFeeDa = houseNoticeFeeDa;
  String? get houseWarrantFeeDa => _houseWarrantFeeDa;
  set houseWarrantFeeDa(String? houseWarrantFeeDa) =>
      _houseWarrantFeeDa = houseWarrantFeeDa;
  String? get houseArrearsDa => _houseArrearsDa;
  set houseArrearsDa(String? houseArrearsDa) => _houseArrearsDa = houseArrearsDa;
  String? get housePenaltyDa => _housePenaltyDa;
  set housePenaltyDa(String? housePenaltyDa) => _housePenaltyDa = housePenaltyDa;
  String? get houseCurrentDa => _houseCurrentDa;
  set houseCurrentDa(String? houseCurrentDa) => _houseCurrentDa = houseCurrentDa;
  String? get houseNoticeFeeCa => _houseNoticeFeeCa;
  set houseNoticeFeeCa(String? houseNoticeFeeCa) =>
      _houseNoticeFeeCa = houseNoticeFeeCa;
  String? get houseWarrantFeeCa => _houseWarrantFeeCa;
  set houseWarrantFeeCa(String? houseWarrantFeeCa) =>
      _houseWarrantFeeCa = houseWarrantFeeCa;
  String? get houseArrearsCa => _houseArrearsCa;
  set houseArrearsCa(String? houseArrearsCa) => _houseArrearsCa = houseArrearsCa;
  String? get housePenaltyCa => _housePenaltyCa;
  set housePenaltyCa(String? housePenaltyCa) => _housePenaltyCa = housePenaltyCa;
  String? get houseCurrentCa => _houseCurrentCa;
  set houseCurrentCa(String? houseCurrentCa) => _houseCurrentCa = houseCurrentCa;
  String? get garbageArrearsDa => _garbageArrearsDa;
  set garbageArrearsDa(String? garbageArrearsDa) =>
      _garbageArrearsDa = garbageArrearsDa;
  String? get garbageCurrentDa => _garbageCurrentDa;
  set garbageCurrentDa(String? garbageCurrentDa) =>
      _garbageCurrentDa = garbageCurrentDa;
  String? get garbageArrearsCa => _garbageArrearsCa;
  set garbageArrearsCa(String? garbageArrearsCa) =>
      _garbageArrearsCa = garbageArrearsCa;
  String? get garbageCurrentCa => _garbageCurrentCa;
  set garbageCurrentCa(String? garbageCurrentCa) =>
      _garbageCurrentCa = garbageCurrentCa;
  bool? get paid => _paid;
  set paid(bool? paid) => _paid = paid;
  int? get totalHouseTax => _totalHouseTax;
  set totalHouseTax(int? totalHouseTax) => _totalHouseTax = totalHouseTax;
  int? get totalGarbageTax => _totalGarbageTax;
  set totalGarbageTax(int? totalGarbageTax) =>
      _totalGarbageTax = totalGarbageTax;
  int? get amountPayable => _amountPayable;
  set amountPayable(int? amountPayable) => _amountPayable = amountPayable;

  Data.fromJson(Map<String, dynamic> json) {
    _panchayat = json['panchayat'];
    _revenueVillage = json['revenue_village'];
    _ownerName = json['owner_name'];
    _houseNo = json['house_no'];
    _address = json['address'];
    _occupierName = json['occupier_name'];
    _financialYear = json['financial_year'];
    _houseNoticeFeeDa = json['house_notice_fee_da'];
    _houseWarrantFeeDa = json['house_warrant_fee_da'];
    _houseArrearsDa = json['house_arrears_da'];
    _housePenaltyDa = json['house_penalty_da'];
    _houseCurrentDa = json['house_current_da'];
    _houseNoticeFeeCa = json['house_notice_fee_ca'];
    _houseWarrantFeeCa = json['house_warrant_fee_ca'];
    _houseArrearsCa = json['house_arrears_ca'];
    _housePenaltyCa = json['house_penalty_ca'];
    _houseCurrentCa = json['house_current_ca'];
    _garbageArrearsDa = json['garbage_arrears_da'];
    _garbageCurrentDa = json['garbage_current_da'];
    _garbageArrearsCa = json['garbage_arrears_ca'];
    _garbageCurrentCa = json['garbage_current_ca'];
    _paid = json['paid'];
    _totalHouseTax = json['total_house_tax'];
    _totalGarbageTax = json['total_garbage_tax'];
    _amountPayable = json['amount_payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['panchayat'] = this._panchayat;
    data['revenue_village'] = this._revenueVillage;
    data['owner_name'] = this._ownerName;
    data['house_no'] = this._houseNo;
    data['address'] = this._address;
    data['occupier_name'] = this._occupierName;
    data['financial_year'] = this._financialYear;
    data['house_notice_fee_da'] = this._houseNoticeFeeDa;
    data['house_warrant_fee_da'] = this._houseWarrantFeeDa;
    data['house_arrears_da'] = this._houseArrearsDa;
    data['house_penalty_da'] = this._housePenaltyDa;
    data['house_current_da'] = this._houseCurrentDa;
    data['house_notice_fee_ca'] = this._houseNoticeFeeCa;
    data['house_warrant_fee_ca'] = this._houseWarrantFeeCa;
    data['house_arrears_ca'] = this._houseArrearsCa;
    data['house_penalty_ca'] = this._housePenaltyCa;
    data['house_current_ca'] = this._houseCurrentCa;
    data['garbage_arrears_da'] = this._garbageArrearsDa;
    data['garbage_current_da'] = this._garbageCurrentDa;
    data['garbage_arrears_ca'] = this._garbageArrearsCa;
    data['garbage_current_ca'] = this._garbageCurrentCa;
    data['paid'] = this._paid;
    data['total_house_tax'] = this._totalHouseTax;
    data['total_garbage_tax'] = this._totalGarbageTax;
    data['amount_payable'] = this._amountPayable;
    return data;
  }
}
