import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:image/image.dart' as img;
import 'package:styled_divider/styled_divider.dart';
import 'package:we_panchayat_dev/models/income_certificate_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/screens/income_certificate/income_certificate.dart';
import 'package:we_panchayat_dev/services/income_certificate_api_service.dart';
import 'package:we_panchayat_dev/services/trade_license_api_service.dart';

import '../../constants.dart';
import '../../services/applications_api_service.dart';

import 'package:path_provider/path_provider.dart';

class IncomeCertificateReviewForm extends StatefulWidget {
  final IncomeCertificateFormResponseModel incomeCertificate;

  const IncomeCertificateReviewForm(
      {super.key, required this.incomeCertificate});

  @override
  _IncomeCertificateReviewFormState createState() =>
      _IncomeCertificateReviewFormState();
}

class _IncomeCertificateReviewFormState
    extends State<IncomeCertificateReviewForm>
    with SingleTickerProviderStateMixin {
  Map<String, File?> _fileMap = {};
  Map<String, String> _formData = {};

  final Map<String, String> fileNamesMap = {
    "rationCard": "Ration Card",
    "aadharCard": "Aadhar Card",
    "form16": "Form 16",
    "salaryCertificate": "Salary Certificate",
    "bankPassbook": "Bank Passbook",
    "selfDeclaration": "Self Declaration",
    "photo": "Photo",
  };

  final List<String> incomeCertificateApplicationStatus = [
    'Application submitted',
    'Scrutinized',
    'Payment',
    'Issue of License/Certificate',
    'Download',
  ];

  int _currentStep = 0;

  final Color _darkBlueButton = const Color(0xff356899);

  bool _isTabChanged = false;

  bool _isEdit = true;

  late int _applicationStatusActiveIndex = 4;

  late String _applicationRemark = "Remark";

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Details'),
    const Tab(text: 'Status'),
  ];

  // Define the TabController
  TabController? _tabController;

  File? tempFile;

  late IncomeCertificateFormResponseModel _incomeCertificateFormResponseModel;

  String? _tempPath;

  void _initTempPath() async {
    Directory? tempDir = await getExternalStorageDirectory();

    setState(() {
      if (tempDir != null) {
        _tempPath = tempDir.path;
      }

      _formData = {
        "application_id":
            _incomeCertificateFormResponseModel.data.applicationId ?? 'null',
        "mongo_id": _incomeCertificateFormResponseModel.data.mongoId ?? 'null',
        "taluka": _incomeCertificateFormResponseModel.data.taluka ?? 'null',
        "panchayat":
            _incomeCertificateFormResponseModel.data.panchayat ?? 'null',
        "title": _incomeCertificateFormResponseModel.data.title ?? 'null',
        "applicants_name":
            _incomeCertificateFormResponseModel.data.applicantsName ?? 'null',
        "applicants_address":
            _incomeCertificateFormResponseModel.data.applicantsAddress ??
                'null',
        "phone": _incomeCertificateFormResponseModel.data.phone ?? 'null',
        "email": _incomeCertificateFormResponseModel.data.email ?? 'null',
        "parents_name":
            _incomeCertificateFormResponseModel.data.parentsName ?? 'null',
        "id_proof": _incomeCertificateFormResponseModel.data.idProof ?? 'null',
        "id_proof_no":
            _incomeCertificateFormResponseModel.data.idProofNo ?? 'null',
        "date_of_birth":
            _incomeCertificateFormResponseModel.data.dateOfBirth ?? 'null',
        "applicants_relation":
            _incomeCertificateFormResponseModel.data.applicantsRelation ??
                'null',
        "place_of_birth":
            _incomeCertificateFormResponseModel.data.placeOfBirth ?? 'null',
        "occupation":
            _incomeCertificateFormResponseModel.data.occupation ?? 'null',
        "annual_income":
            _incomeCertificateFormResponseModel.data.annualIncome ?? 'null',
        "from_year":
            _incomeCertificateFormResponseModel.data.fromYear ?? 'null',
        'to_year': _incomeCertificateFormResponseModel.data.toYear ?? 'null',
        "marital_status":
            _incomeCertificateFormResponseModel.data.maritalStatus ?? 'null',
        "to_produce_at":
            _incomeCertificateFormResponseModel.data.toProduceAt ?? 'null',
        "purpose": _incomeCertificateFormResponseModel.data.purpose ?? 'null',
        "can_edit_from":
            _incomeCertificateFormResponseModel.data.canUpdate.toString(),
      };

      _applicationStatusActiveIndex = incomeCertificateApplicationStatus
          .indexOf(_incomeCertificateFormResponseModel.data.status!);
      _applicationRemark =
          _incomeCertificateFormResponseModel.data.remark ?? "Remark";

      _isEdit = _incomeCertificateFormResponseModel.data.canUpdate!;
    });

    List<int>? binaryData;

    binaryData =
        _incomeCertificateFormResponseModel.data.documents?.rationCard?.data;
    assignFile(fileNamesMap.keys.elementAt(0), fileNamesMap.values.elementAt(0),
        binaryData, false);

    binaryData =
        _incomeCertificateFormResponseModel.data.documents?.aadharCard?.data;
    assignFile(fileNamesMap.keys.elementAt(1), fileNamesMap.values.elementAt(1),
        binaryData, false);

    if (_incomeCertificateFormResponseModel.data.documents?.form16 != null) {
      binaryData =
          _incomeCertificateFormResponseModel.data.documents?.form16?.data;
      assignFile(fileNamesMap.keys.elementAt(2),
          fileNamesMap.values.elementAt(2), binaryData, false);
    } else if (_incomeCertificateFormResponseModel
            .data.documents?.bankPassbook !=
        null) {
      binaryData = _incomeCertificateFormResponseModel
          .data.documents?.bankPassbook?.data;
      assignFile(fileNamesMap.keys.elementAt(4),
          fileNamesMap.values.elementAt(4), binaryData, false);
    } else if (_incomeCertificateFormResponseModel
            .data.documents?.salaryCertificate !=
        null) {
      binaryData = _incomeCertificateFormResponseModel
          .data.documents?.salaryCertificate?.data;
      assignFile(fileNamesMap.keys.elementAt(3),
          fileNamesMap.values.elementAt(3), binaryData, false);
    }

    binaryData = _incomeCertificateFormResponseModel
        .data.documents?.selfDeclaration?.data;
    assignFile(fileNamesMap.keys.elementAt(5), fileNamesMap.values.elementAt(5),
        binaryData, false);

    binaryData =
        _incomeCertificateFormResponseModel.data.documents?.photo?.data;
    assignFile(fileNamesMap.keys.elementAt(6), fileNamesMap.values.elementAt(6),
        binaryData, true);
  }

  @override
  void initState() {
    super.initState();
    _incomeCertificateFormResponseModel = widget.incomeCertificate;

    _initTempPath();

    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('MMMM dd yyyy').format(date);
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

  Future<File?> binaryToTempFile(
      String filename, List<int>? binaryData, bool isImage) async {
    // final directory = await getTemporaryDirectory();
    if (binaryData != null && _tempPath != null) {
      final File file;
      if (isImage) {
        // Decode binary data to image
        img.Image? image = img.decodeImage(binaryData);
        // Encode image to JPEG format
        List<int> jpeg = img.encodeJpg(image!);
        file = File('$_tempPath/$filename.jpeg');
        print('$filename.jpeg');

        await file.writeAsBytes(jpeg);

        return file;
      } else {
        file = File('$_tempPath/$filename.pdf');
        print('$filename.pdf');
      }
      // final file = File('$_tempPath/$filename.pdf');
      await file.writeAsBytes(binaryData);
      return file;
    }
    return null;
  }

  void assignFile(
      String key, String filename, List<int>? binaryData, bool isImage) async {
    File? pdfFile = await binaryToTempFile(filename, binaryData, isImage);
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

    print(_fileMap);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundClipperColor,
        foregroundColor: ColorConstants.darkBlueThemeColor,
        title: Text(
          'Income Certificate - Review',
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
                      builder: (context) => IncomeCertificate(
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
              // color: Colors.white,
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
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Image.memory(
                                          Uint8List.fromList(_fileMap["photo"]
                                                  ?.readAsBytesSync()
                                              as List<int>),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 180,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${_formData["title"]} ${_formData["applicants_name"]}",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "${formatDate(_formData["date_of_birth"]!)}",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "${_formData["phone"]}",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
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
                                _buildSection("Parent's/ Husband's Name",
                                    _formData["parents_name"]!),
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
                                _buildSection('Email', _formData["email"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection(
                                    'Id Proof', _formData["id_proof"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection('Id Proof Number',
                                    _formData["id_proof_no"]!),
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
                                _buildSection('Place Of Birth',
                                    _formData["place_of_birth"]!),
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
                                _buildSection("Applicant's Address",
                                    _formData["applicants_address"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection(
                                    'Occupation', _formData["occupation"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection('Annual Income',
                                    _formData["annual_income"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection(
                                    'From Year', _formData["from_year"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection(
                                    'From Year', _formData["from_year"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection(
                                    'To Year', _formData["to_year"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection('Marital Status',
                                    _formData["marital_status"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection('To produce at',
                                    _formData["to_produce_at"]!),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                _buildSection(
                                    'Purpose', _formData["purpose"]!),
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
                                  "Documents",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    fontSize: 16,
                                    color: ColorConstants.lightBlackColor,
                                  ),
                                ),

                                if (_fileMap["rationCard"] != null) ...[
                                  _buildPDFListItem(
                                      'Ration Card (Self Attested)',
                                      _fileMap["rationCard"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                                if (_fileMap["aadharCard"] != null) ...[
                                  _buildPDFListItem(
                                      'Aadhar Card (Self Attested)',
                                      _fileMap["aadharCard"]!),
                                  const Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                                if (_fileMap["form16"] != null) ...[
                                  _buildPDFListItem(
                                      'Form 16', _fileMap["form16"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                                if (_fileMap["bankPassbook"] != null) ...[
                                  _buildPDFListItem(
                                    'Bank PassBook(Pensioner)',
                                    _fileMap["bankPassbook"]!,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                                if (_fileMap["salaryCertificate"] !=
                                    null) ...[
                                  _buildPDFListItem('Salary Certificate',
                                      _fileMap["salaryCertificate"]!),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                                if (_fileMap["selfDeclaration"] != null) ...[
                                  _buildPDFListItem('Self Declaration',
                                      _fileMap["selfDeclaration"]!),
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
                                            _incomeCertificateFormResponseModel
                                                .data.applicationId!,
                                      };
                                      IncomeCertificateAPIService
                                          .generateCertificatePDF(body);
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
            'Scrutinized',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 1
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your application is being scrutinized.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 1
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.search_outlined,
                color: _applicationStatusActiveIndex >= 1
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Payment',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 2
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Please complete the payment.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 2
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.currency_rupee,
                color: _applicationStatusActiveIndex >= 2
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Issue of License/Certificate',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 3
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle: StepperText('Your license/certificate is being issued.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 3
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.file_open,
                color: _applicationStatusActiveIndex >= 3
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
        StepperData(
          title: StepperText(
            'Download',
            textStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: _applicationStatusActiveIndex >= 4
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          subtitle:
              StepperText('You can now download your license/certificate.'),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _applicationStatusActiveIndex >= 4
                    ? Color(0xffEBFFD7)
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.download,
                color: _applicationStatusActiveIndex >= 4
                    ? Color(0xff28B446)
                    : Colors.white),
          ),
        ),
      ];
}
