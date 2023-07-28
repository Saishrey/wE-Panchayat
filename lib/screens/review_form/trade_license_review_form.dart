import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:open_file/open_file.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/screens/tradelicense/tradelicense.dart';
import 'package:we_panchayat_dev/services/trade_license_api_service.dart';

import 'package:path_provider/path_provider.dart';

import '../../constants.dart';

class TradeLicenseReviewForm extends StatefulWidget {
  final TradeLicenseFormResponseModel license;

  const TradeLicenseReviewForm({super.key, required this.license});

  @override
  _TradeLicenseReviewFormState createState() => _TradeLicenseReviewFormState();
}

class _TradeLicenseReviewFormState extends State<TradeLicenseReviewForm>
    with SingleTickerProviderStateMixin {
  Map<String, File?> _fileMap = {};
  Map<String, String> _formData = {};

  final Map<String, String> fileNamesMap = {
    "identityProof": "Identity Proof",
    "houseTax": "House tax",
    "ownershipDocument": "Ownership Document",
    "permissionsGranted.foodAndDrugs": "Food and Drugs",
    "permissionsGranted.excise": "Excise",
    "permissionsGranted.policeDepartment": "Police Department",
    "permissionsGranted.crz": "CRZ",
    "permissionsGranted.tourism": "Tourism",
    "permissionsGranted.fireAndBridge": "Fire Brigade",
    "permissionsGranted.factoriesAndBoilers": "Factories and Boilers",
    "permissionsGranted.healthServices": "Health Services",
    "permissionsGranted.others.file": "Others",
  };

  final List<String> tradeLicenseApplicationStatus = [
    'Application submitted',
    'Processing Fees Payment',
    'Site Inspection',
    'Panchayat Body Decision',
    'Scrutinized',
    'Payment',
    'Issue of License/Certificate',
    'Download',
  ];

  int _currentStep = 0;

  final Color _darkBlueButton = const Color(0xff356899);

  bool _isTabChanged = false;

  bool _isEdit = true;

  late int _applicationStatusActiveIndex = 7;

  late String _applicationRemark = "Remark";

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Details'),
    const Tab(text: 'Status'),
  ];

  // Define the TabController
  TabController? _tabController;

  File? tempFile;

  late TradeLicenseFormResponseModel _licenseFormResponseModel;

  String? _tempPath;

  void _initTempPath() async {
    Directory? tempDir = await getExternalStorageDirectory();

    print("CAN UPDATE : ${_licenseFormResponseModel.data.canUpdate}");
    print(_licenseFormResponseModel.data.canUpdate.toString() == "true");

    setState(() {
      if (tempDir != null) {
        _tempPath = tempDir.path;
      }

      _formData = {
        "application_id":
            _licenseFormResponseModel.data.applicationId ?? 'null',
        "signboard_id": _licenseFormResponseModel.data.signboardId ?? 'null',
        "mongo_id": _licenseFormResponseModel.data.mongoId ?? 'null',
        "taluka": _licenseFormResponseModel.data.taluka ?? 'null',
        "panchayat": _licenseFormResponseModel.data.panchayat ?? 'null',
        "applicants_name":
            _licenseFormResponseModel.data.applicantsName ?? 'null',
        "applicants_address":
            _licenseFormResponseModel.data.applicantsAddress ?? 'null',
        "phone": _licenseFormResponseModel.data.phone ?? 'null',
        "ward_no": _licenseFormResponseModel.data.wardNo ?? 'null',
        "shop_no": _licenseFormResponseModel.data.shopNo ?? 'null',
        "owner_name": _licenseFormResponseModel.data.ownerName ?? 'null',
        "trade_name": _licenseFormResponseModel.data.tradeName ?? 'null',
        "trade_address": _licenseFormResponseModel.data.tradeAddress ?? 'null',
        "applicants_relation":
            _licenseFormResponseModel.data.applicantsRelation ?? 'null',
        "trade_type": _licenseFormResponseModel.data.tradeType ?? 'null',
        "business_nature":
            _licenseFormResponseModel.data.businessNature ?? 'null',
        "waste_management_facility":
            _licenseFormResponseModel.data.wasteManagementFacility ?? 'null',
        "lease_pay": _licenseFormResponseModel.data.leasePay ?? 'null',
        'trade_area': _licenseFormResponseModel.data.tradeArea ?? 'null',
        "no_of_employee": _licenseFormResponseModel.data.noOfEmployee ?? 'null',
        "signboard_details":
            _licenseFormResponseModel.data.signboardDetails.toString(),
        "signboard_location":
            _licenseFormResponseModel.data.signboardLocation ?? 'null',
        "signboard_type":
            _licenseFormResponseModel.data.signboardType ?? 'null',
        "signboard_content":
            _licenseFormResponseModel.data.signboardContent ?? 'null',
        "signboard_area":
            _licenseFormResponseModel.data.signboardArea ?? 'null',
      };

      _applicationStatusActiveIndex = tradeLicenseApplicationStatus
          .indexOf(_licenseFormResponseModel.data.status!);
      _applicationRemark = _licenseFormResponseModel.data.remark ?? "Remark";

      _isEdit = _licenseFormResponseModel.data.canUpdate!;
    });

    List<int>? binaryData;

    binaryData = _licenseFormResponseModel.data.documents?.identityProof?.data;
    assignFile(fileNamesMap.keys.elementAt(0), fileNamesMap.values.elementAt(0),
        binaryData);

    binaryData = _licenseFormResponseModel.data.documents?.houseTax?.data;
    assignFile(fileNamesMap.keys.elementAt(1), fileNamesMap.values.elementAt(1),
        binaryData);

    binaryData =
        _licenseFormResponseModel.data.documents?.ownershipDocument?.data;
    assignFile(fileNamesMap.keys.elementAt(2), fileNamesMap.values.elementAt(2),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedFoodAndDrugs?.data;
    assignFile(fileNamesMap.keys.elementAt(3), fileNamesMap.values.elementAt(3),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedExcise?.data;
    assignFile(fileNamesMap.keys.elementAt(4), fileNamesMap.values.elementAt(4),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedPoliceDepartment?.data;
    assignFile(fileNamesMap.keys.elementAt(5), fileNamesMap.values.elementAt(5),
        binaryData);

    binaryData =
        _licenseFormResponseModel.data.documents?.permissionsGrantedCrz?.data;
    assignFile(fileNamesMap.keys.elementAt(6), fileNamesMap.values.elementAt(6),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedTourism?.data;
    assignFile(fileNamesMap.keys.elementAt(7), fileNamesMap.values.elementAt(7),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedFireAndBridge?.data;
    assignFile(fileNamesMap.keys.elementAt(8), fileNamesMap.values.elementAt(8),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedFactoriesAndBoilers?.data;
    assignFile(fileNamesMap.keys.elementAt(9), fileNamesMap.values.elementAt(9),
        binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedHealthServices?.data;
    assignFile(fileNamesMap.keys.elementAt(10),
        fileNamesMap.values.elementAt(10), binaryData);

    binaryData = _licenseFormResponseModel
        .data.documents?.permissionsGrantedOthersFile?.data;
    assignFile(fileNamesMap.keys.elementAt(11),
        fileNamesMap.values.elementAt(11), binaryData);
  }

  @override
  void initState() {
    super.initState();
    _licenseFormResponseModel = widget.license;

    _initTempPath();

    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  Future<File?> binaryToTempFile(String filename, List<int>? binaryData) async {
    // final directory = await getTemporaryDirectory();
    if (binaryData != null && _tempPath != null) {
      final file = File('$_tempPath/$filename.pdf');
      await file.writeAsBytes(binaryData);
      return file;
    }
    return null;
  }

  void assignFile(String key, String filename, List<int>? binaryData) async {
    File? pdfFile = await binaryToTempFile(filename, binaryData);
    if (pdfFile != null) {
      setState(() {
        _fileMap[key] = pdfFile;
      });
    }
  }

  Future<bool> _handleBackPressed() async {
    // Delete files from the file map
    _fileMap.values.forEach((file) {
      // file.deleteSync();
      if (file != null) {
        file.deleteSync();
        print('File deleted');
      } else {
        print('File not found');
      }
    });

    return true; // Allow the app to be closed
  }

  @override
  Widget build(BuildContext context) {
    // if(_licenseFormResponseModel == null) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    // print(_fileMap);
    // print(_formData);

    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.backgroundClipperColor,
          foregroundColor: ColorConstants.darkBlueThemeColor,
          title: Text(
            'Trade License & Signboard - Review',
            style: TextStyle(
                fontFamily: 'Poppins-Medium',
                color: ColorConstants.darkBlueThemeColor,
                fontSize: 18),
          ),
          elevation: 0,
          actions: <Widget>[
            Visibility(
              visible: _isEdit,
              child: IconButton(
                icon: const Icon(Icons.edit_document),
                onPressed: () {
                  // do something
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TradeLicense(
                            fileMap: {..._fileMap},
                            formData: {..._formData},
                            isEdit: true)),
                  );
                },
              ),
            ),
          ],
          actionsIconTheme: IconThemeData(
            color: ColorConstants.darkBlueThemeColor,
            size: 28,
          ),
        ),
        backgroundColor: ColorConstants.backgroundClipperColor,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: _darkBlueButton,
                ),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Details',
                        style: TextStyle(fontFamily: 'Poppins-Medium'),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: _darkBlueButton),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Status',
                        style: TextStyle(fontFamily: 'Poppins-Medium'),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: _darkBlueButton),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  if (_formData.isEmpty || _fileMap.isEmpty) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ] else ...[
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0,
                                        2), // changes the position of the shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Applicant Details",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 16,
                                      color: ColorConstants.lightBlackColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  _buildSection('Taluka', _formData["taluka"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection(
                                      'Panchayat', _formData["panchayat"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection("Applicant's Name",
                                      _formData["applicants_name"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection(
                                      'Mobile No.', _formData["phone"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection(
                                      'Ward No.', _formData["ward_no"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection(
                                      'Shop No.', _formData["shop_no"]!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0,
                                        2), // changes the position of the shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Trade Details",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 16,
                                      color: ColorConstants.lightBlackColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  _buildSection('Name of Owner',
                                      _formData["owner_name"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection('Name of Trade',
                                      _formData["trade_name"]!),
                                  // const Divider(
                                  //   thickness: 1,
                                  // ),
                                  // _buildSection('Title', _formData["title"]!),
                                  // const Divider(
                                  //   thickness: 1,
                                  // ),
                                  // _buildSection("Applicant's Name",
                                  //     _formData["applicants_name"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection("Trade Address",
                                      _formData["trade_address"]!),
                                  // const Divider(
                                  //   thickness: 1,
                                  // ),
                                  // _buildSection(
                                  //     'Mobile No.', _formData["phone"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection("Applicant's Relation",
                                      _formData["applicants_relation"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection('Type of Trade',
                                      _formData["trade_type"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection('Nature of Business',
                                      _formData["business_nature"]!),
                                  // const Divider(
                                  //   thickness: 1,
                                  // ),
                                  // _buildSection('Date Of Birth',
                                  //     formatDate(_formData["date_of_birth"]!)),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection('Waste Management-facility',
                                      _formData["waste_management_facility"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection("Applicant's Relation",
                                      _formData["applicants_relation"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection(
                                      "Lease Pay", _formData["lease_pay"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection('Trade Area (sq.Mts)',
                                      _formData["trade_area"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  _buildSection('No. of Employees',
                                      _formData["no_of_employee"]!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_formData["signboard_details"] == "true") ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0,
                                          2), // changes the position of the shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Signboard Details",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 16,
                                        color: ColorConstants.lightBlackColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    _buildSection('Signboard Location',
                                        _formData["signboard_location"]!),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    _buildSection('Signboard Type',
                                        _formData["signboard_type"]!),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    _buildSection("Content on Board",
                                        _formData["signboard_content"]!),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    _buildSection("Area(sq.Ft)",
                                        _formData["signboard_area"]!),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0,
                                        2), // changes the position of the shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Documents",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 16,
                                      color: ColorConstants.lightBlackColor,
                                    ),
                                  ),
                                  if (_fileMap["identityProof"] != null) ...[
                                    _buildPDFListItem('Identity Proof',
                                        _fileMap["identityProof"]!),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ],
                                  if (_fileMap["houseTax"] != null) ...[
                                    _buildPDFListItem('Housetax Receipt',
                                        _fileMap["houseTax"]!),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ],
                                  if (_fileMap["ownershipDocument"] !=
                                      null) ...[
                                    _buildPDFListItem(
                                        'No Objection Certificate/ Lease agreement/ Ownership document',
                                        _fileMap["ownershipDocument"]!),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  if (_fileMap.length > 3) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: Text(
                                        "Permissions granted by the Authorities as per requirement",
                                        style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 12,
                                          color: ColorConstants.lightBlackColor,
                                        ),
                                      ),
                                    ),
                                    if (_fileMap[
                                            "permissionsGranted.foodAndDrugs"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                        'Foods & Drugs',
                                        _fileMap[
                                            "permissionsGranted.foodAndDrugs"]!,
                                      ),
                                    ],
                                    if (_fileMap["permissionsGranted.excise"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Excise',
                                          _fileMap[
                                              "permissionsGranted.excise"]!),
                                    ],
                                    if (_fileMap[
                                            "permissionsGranted.policeDepartment"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Police Dept.',
                                          _fileMap[
                                              "permissionsGranted.policeDepartment"]!),
                                    ],
                                    if (_fileMap["permissionsGranted.crz"] !=
                                        null) ...[
                                      _buildPDFListItem('CRZ',
                                          _fileMap["permissionsGranted.crz"]!),
                                    ],
                                    if (_fileMap[
                                            "permissionsGranted.tourism"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Tourism',
                                          _fileMap[
                                              "permissionsGranted.tourism"]!),
                                    ],
                                    if (_fileMap[
                                            "permissionsGranted.fireAndBridge"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Fire Brigade',
                                          _fileMap[
                                              "permissionsGranted.fireAndBridge"]!),
                                    ],
                                    if (_fileMap[
                                            "permissionsGranted.factoriesAndBoilers"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Factories & Boilers',
                                          _fileMap[
                                              "permissionsGranted.factoriesAndBoilers"]!),
                                    ],
                                    if (_fileMap[
                                            "permissionsGranted.healthServices"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Health Services',
                                          _fileMap[
                                              "permissionsGranted.healthServices"]!),
                                    ],
                                    if (_fileMap[
                                            "permissionsGranted.others.file"] !=
                                        null) ...[
                                      _buildPDFListItem(
                                          'Others',
                                          _fileMap[
                                              "permissionsGranted.others.file"]!),
                                    ],
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: AnotherStepper(
                                stepperDirection: Axis.vertical,
                                verticalGap: 15,
                                iconWidth: 60,
                                iconHeight: 60,
                                activeBarColor: Color(0xff28B446),
                                inActiveBarColor: Colors.grey,
                                activeIndex: _applicationStatusActiveIndex,
                                barThickness: 2,
                                stepperList: getStatusSteps(),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Remark:",
                                    style: TextStyle(
                                      color: Color(0xffFF0000),
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _applicationRemark,
                                      style: TextStyle(
                                        color: Color(0xffFF0000),
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: ElevatedButton(
                                onPressed: _applicationStatusActiveIndex ==
                                        getStatusSteps().length - 1
                                    ? () async {
                                        Map<String, String> body = {
                                          "application_id":
                                              _licenseFormResponseModel
                                                  .data.applicationId!,
                                        };
                                        TradeLicenseAPIService
                                            .generateLicensePDF(body);
                                      }
                                    : null,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          _applicationStatusActiveIndex ==
                                                  getStatusSteps().length - 1
                                              ? Color(0xff6CC51D)
                                              : Colors.grey),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      // side: BorderSide(
                                      //     color: _applicationStatusActiveIndex ==
                                      //             getDetailsSteps().length - 1
                                      //         ? Color(0xff6CC51D)
                                      //         : Colors.grey),
                                    ),
                                  ),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.only(top: 15.0, bottom: 15.0),
                                  ),
                                ),
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Bold',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Poppins-Light',
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPDFListItem(String title, File file) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: () async {
                      // Add your desired logic or function here
                      // This function will be called when the icon button is pressed
                      String filePath = file.path;
                      var r = await OpenFile.open(filePath);
                      print("MESSAGE: ${r.message}");
                    },
                    child: Ink(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Icon(
                        Icons.open_in_new_rounded,
                        color: ColorConstants.formLabelTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<StepperData> getStatusSteps() => [
        StepperData(
          title: StepperText(
            'Application Submitted',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 0
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your application has been submitted.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 0
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.check,
                color: _applicationStatusActiveIndex >= 0
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Processing Fees Payment',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 1
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your fees payments is being processed.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 1
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.payment,
                color: _applicationStatusActiveIndex >= 1
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Site Inspection',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 2
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your site is being inspected.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 2
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.landscape,
                color: _applicationStatusActiveIndex >= 2
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Panchayat Body Decision',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 3
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Panchayat body is taking decision.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 3
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.people,
                color: _applicationStatusActiveIndex >= 3
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Scrutinized',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 4
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your application is being scrutinized.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 4
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.search_outlined,
                color: _applicationStatusActiveIndex >= 4
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Payment',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 5
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Please complete the payment.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 5
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.currency_rupee,
                color: _applicationStatusActiveIndex >= 5
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Issue of License/Certificate',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 6
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your license/certificate is being issued.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 6
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.file_open,
                color: _applicationStatusActiveIndex >= 6
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Download',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 7
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle:
              StepperText('You can now download your license/certificate.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 7
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.download,
                color: _applicationStatusActiveIndex >= 7
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
      ];
}
