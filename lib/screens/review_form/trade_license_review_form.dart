import 'dart:io';

import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:open_file/open_file.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/screens/tradelicense/tradelicense.dart';
import 'package:we_panchayat_dev/services/trade_license_api_service.dart';


import 'package:path_provider/path_provider.dart';

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

    setState(() {
      if (tempDir != null) {
        _tempPath = tempDir.path;
      }

      _formData = {
        "application_id": _licenseFormResponseModel.data.applicationId ?? 'null',
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

  Future<void> deleteTempFiles() async {
    Directory tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      List<FileSystemEntity> entities = tempDir.listSync();
      entities.forEach((entity) {
        if (entity is File) {
          entity.deleteSync();
        } else if (entity is Directory) {
          entity.deleteSync(recursive: true);
        }
      });
      tempDir.deleteSync();
    }
    print("TEMP FILES DELETED");
  }

  @override
  void dispose() {
    _tabController?.dispose();

    deleteTempFiles();

    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    // if(_licenseFormResponseModel == null) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    // print(_fileMap);
    // print(_formData);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffDAF5FF),
        foregroundColor: Color(0xff415EB6),
        title: const Text(
          'Trade License & Signboard',
          style: TextStyle(
              fontFamily: 'Poppins-Medium',
              color: Color(0xff415EB6),
              fontSize: 18),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit_document),
            onPressed: () {
              // do something
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TradeLicense(fileMap: {..._fileMap}, formData: {..._formData}, isEdit: true)),
              );
            },
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: _darkBlueButton,
          size: 28,
        ),
      ),
      backgroundColor: Color(0xffDAF5FF),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
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
                      color: Colors.white,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xff6CC51D),
                        ),
                      ),
                      child: Stepper(
                        currentStep: _currentStep,
                        type: StepperType.horizontal,
                        onStepContinue: () {
                          setState(() {
                            if (_currentStep < 2) {
                              _currentStep++;
                            }
                          });
                        },
                        onStepTapped: (step) {
                          setState(() {
                            _currentStep = step;
                          });
                        },
                        onStepCancel: () {
                          setState(() {
                            if (_currentStep > 0) {
                              _currentStep--;
                            }
                          });
                        },
                        steps: getDetailsSteps(),
                        controlsBuilder: (BuildContext context,
                            ControlsDetails controlsDetails) {
                          return Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            width: double.infinity,
                            child: Row(
                              children: [
                                if (_currentStep > 0) ...[
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: controlsDetails.onStepCancel,
                                      child: Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Bold',
                                          color: Colors.black54,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.black54),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (0 < _currentStep && _currentStep < 2) ...[
                                  const SizedBox(width: 10.0),
                                ],
                                if (_currentStep < 2) ...[
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: controlsDetails.onStepContinue,
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Bold',
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF5386E4)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          );
                        },
                      ),
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
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
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
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
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
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: ElevatedButton(
                              onPressed: _applicationStatusActiveIndex ==
                                      getStatusSteps().length - 1
                                  ? () async {
                                      Map<String, String> body = {
                                        "application_id":
                                            _licenseFormResponseModel
                                                .data.applicationId!,
                                      };
                                      TradeLicenseAPIService.generateLicensePDF(
                                          body);
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
                                    borderRadius: BorderRadius.circular(50.0),
                                    // side: BorderSide(
                                    //     color: _applicationStatusActiveIndex ==
                                    //             getDetailsSteps().length - 1
                                    //         ? Color(0xff6CC51D)
                                    //         : Colors.grey),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
    );
  }

  Widget _buildPDFListItem(File pdfFile) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Material(
        child: InkWell(
          onTap: () async {
            print("OPEN FILE");
            // do not change this code
            String filePath = pdfFile.path;
            var r = await OpenFile.open(filePath);
            print("MESSAGE: ${r.message}");
          },
          child: Ink(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    size: 48.0,
                    color: Color(0xffDD2025),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pdfFile.path.split('/').last,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${(pdfFile.lengthSync() / 1024).toStringAsFixed(2)} KB',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.cloud_done,
                    color: Color(0xFF5386E4),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  //This will be your screens
  List<Step> getDetailsSteps() => [
        Step(
            title: const Text('Applicant', style: TextStyle(
              fontFamily: 'Poppins-Medium',
              color: Colors.black54,
            ),),
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                Text('Applicant Details',
                    style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        color: Colors.black,
                        fontSize: 20)),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        controller:
                            TextEditingController(text: _formData["taluka"]),
                        style: TextStyle(
                          color: Colors.black54, //Name
                          fontFamily: 'Poppins-Bold',
                        ),
                        decoration: InputDecoration(
                          labelText: "Taluka",
                          filled: true,
                          fillColor: Color(0xffF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        controller:
                            TextEditingController(text: _formData["panchayat"]),
                        style: TextStyle(
                          color: Colors.black54, //Name
                          fontFamily: 'Poppins-Bold',
                        ),
                        decoration: InputDecoration(
                          labelText: "Panchayat",
                          filled: true,
                          fillColor: Color(0xffF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: false,
                  controller:
                      TextEditingController(text: _formData["applicants_name"]),
                  style: TextStyle(
                    color: Colors.black54, //Name
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: "Applicant's Name",
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // getFormField("Applicant's Address"),
                TextFormField(
                  enabled: false,
                  controller: TextEditingController(
                      text: _formData["applicants_address"]),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: "Applicant's Address",
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // getFormField("Mobile No."),
                TextFormField(
                  enabled: false,
                  controller: TextEditingController(text: _formData["phone"]),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Mobile No.',
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        controller:
                            TextEditingController(text: _formData["ward_no"]),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black54, //Name
                          fontFamily: 'Poppins-Bold',
                        ),
                        decoration: InputDecoration(
                          labelText: 'Ward No.',
                          filled: true,
                          fillColor: Color(0xffF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        controller:
                            TextEditingController(text: _formData["shop_no"]),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins-Bold',
                        ),
                        decoration: InputDecoration(
                          labelText: 'Shop No.',
                          filled: true,
                          fillColor: Color(0xffF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Step(
          title: const Text('Trade', style: TextStyle(
            fontFamily: 'Poppins-Medium',
            color: Colors.black54,
          ),),
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          content: Column(
            children: [
              Text('Trade Details',
                  style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      color: Colors.black,
                      fontSize: 20)),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller:
                    TextEditingController(text: _formData["owner_name"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Name of Owner',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller:
                    TextEditingController(text: _formData["trade_name"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Name of Trade',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller:
                    TextEditingController(text: _formData["trade_address"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Trade Address',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller: TextEditingController(
                    text: _formData["applicants_relation"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: "Applicant's Relation",
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller:
                    TextEditingController(text: _formData["trade_type"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: "Type of Trade",
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller:
                    TextEditingController(text: _formData["business_nature"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Nature of Business',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller: TextEditingController(
                    text: _formData["waste_management_facility"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Waste Management-facility',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                controller: TextEditingController(text: _formData["lease_pay"]),
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Lease Pay',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: _formData['trade_area']),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Trade Area (sq.Mts)',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: _formData["no_of_employee"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'No. of Employees',
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              if (_formData["signboard_details"] == "true") ...[
                Text('Signboard Details',
                    style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        color: Colors.black,
                        fontSize: 20)),
                SizedBox(height: 16),
                TextFormField(
                  enabled: false,
                  controller: TextEditingController(
                      text: _formData["signboard_location"]),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Signboard Location',
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: false,
                  controller:
                      TextEditingController(text: _formData["signboard_type"]),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Signboard Type',
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: false,
                  controller: TextEditingController(
                      text: _formData["signboard_content"]),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Content on Board',
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  controller:
                      TextEditingController(text: _formData["signboard_area"]),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Area(sq.Ft)',
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: const Text('Documents', style: TextStyle(
            fontFamily: 'Poppins-Medium',
            color: Colors.black54,
          ),),
          content: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Uploaded Documents',
                  style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (_fileMap["identityProof"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Identity Proof',
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 14,
                                color: Color(0xff21205b),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'Required',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 10,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      _buildPDFListItem(_fileMap["identityProof"]!),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["houseTax"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Housetax Receipt',
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 14,
                                color: Color(0xff21205b),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'Required',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 10,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      _buildPDFListItem(_fileMap["houseTax"]!),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["ownershipDocument"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'No Objection Certificate/ Lease argreement/ Ownership document',
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 14,
                                color: Color(0xff21205b),
                              ),
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Required',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 10,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      _buildPDFListItem(_fileMap["ownershipDocument"]!),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
                if (_fileMap.length > 3) ...[
                  const Text(
                    'Permissions granted by the Authorities as per requirement',
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.foodAndDrugs"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Foods & Drugs',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.foodAndDrugs"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.excise"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Excise',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(_fileMap["permissionsGranted.excise"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.policeDepartment"] !=
                    null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Police Dept.',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.policeDepartment"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.crz"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'CRZ',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(_fileMap["permissionsGranted.crz"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.tourism"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Tourism',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.tourism"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.fireAndBridge"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Fire Brigade',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.fireAndBridge"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.factoriesAndBoilers"] !=
                    null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Factories & Boilers',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.factoriesAndBoilers"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.healthServices"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Health Services',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.healthServices"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (_fileMap["permissionsGranted.others.file"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Others',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      _buildPDFListItem(
                          _fileMap["permissionsGranted.others.file"]!),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        )
      ];
}
