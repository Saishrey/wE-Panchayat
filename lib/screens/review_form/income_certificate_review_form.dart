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
    "form16" : "Form 16",
    "salaryCertificate" : "Salary Certificate",
    "bankPassbook" : "Bank Passbook",
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
        "application_id": _incomeCertificateFormResponseModel.data.applicationId ?? 'null',
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
      };

      _applicationStatusActiveIndex = incomeCertificateApplicationStatus
          .indexOf(_incomeCertificateFormResponseModel.data.status!);
      _applicationRemark =
          _incomeCertificateFormResponseModel.data.remark ?? "Remark";
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

    if(_incomeCertificateFormResponseModel.data.documents?.form16 != null) {
      binaryData =
          _incomeCertificateFormResponseModel.data.documents?.form16?.data;
      assignFile(fileNamesMap.keys.elementAt(2), fileNamesMap.values.elementAt(2),
          binaryData, false);
    } else if(_incomeCertificateFormResponseModel.data.documents?.bankPassbook != null) {
      binaryData =
          _incomeCertificateFormResponseModel.data.documents?.bankPassbook?.data;
      assignFile(fileNamesMap.keys.elementAt(4), fileNamesMap.values.elementAt(4),
          binaryData, false);
    } else if(_incomeCertificateFormResponseModel.data.documents?.salaryCertificate != null) {
      binaryData =
          _incomeCertificateFormResponseModel.data.documents?.salaryCertificate?.data;
      assignFile(fileNamesMap.keys.elementAt(3), fileNamesMap.values.elementAt(3),
          binaryData, false);
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
      if(isImage) {
        // Decode binary data to image
        img.Image? image = img.decodeImage(binaryData);
        // Encode image to JPEG format
        List<int> jpeg = img.encodeJpg(image!);
        file = File('$_tempPath/$filename.jpeg');
        print('$filename.jpeg');

        await file.writeAsBytes(jpeg);

        return file;
      }
      else {
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
        backgroundColor: Color(0xffFAD4D4),
        foregroundColor: Color(0xffF45656),
        title: const Text(
          'Income Certificate',
          style: TextStyle(
              fontFamily: 'Poppins-Medium',
              color: Color(0xffF45656),
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
                MaterialPageRoute(builder: (context) => IncomeCertificate(fileMap: {..._fileMap}, formData: {..._formData}, isEdit: true)),
              );
            },
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.red,
          size: 28,
        ),
      ),
      backgroundColor: Color(0xffFAD4D4),
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
                            if (_currentStep < 1) {
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
                                if (_currentStep < 1) ...[
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
                                            _incomeCertificateFormResponseModel
                                                .data.applicationId!,
                                      };
                                      IncomeCertificateAPIService.generateCertificatePDF(
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

  Widget _buildPDFListItem(File file, bool isImage) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Material(
        child: InkWell(
          onTap: () async {
            print("OPEN FILE");
            // do not change this code
            String filePath = file.path;
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
                  if (isImage) ...[
                    const Icon(
                      Icons.image,
                      size: 48.0,
                      color: Color(0xffDD2025),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 48.0,
                      color: Color(0xffDD2025),
                    ),
                  ],
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file.path.split('/').last,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB',
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
              const Text('Applicant Details',
                  style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      color: Colors.black,
                      fontSize: 20)),
              const SizedBox(height: 16),
              SizedBox(
                width: 150.0,
                height: 200.0,
                child: Container(
                  child: Image.memory(
                    Uint8List.fromList(
                        _fileMap["photo"]?.readAsBytesSync() as List<int>),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),
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
                controller: TextEditingController(text: _formData["title"]),
                style: TextStyle(
                  color: Colors.black54, //Name
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: "Title",
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
                    TextEditingController(text: _formData["applicants_name"]),
                style: TextStyle(
                  color: Colors.black54,
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
              TextFormField(
                enabled: false,
                controller:
                    TextEditingController(text: _formData["parents_name"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: "Parent's/ Husband's Name",
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
              TextFormField(
                enabled: false,
                controller: TextEditingController(text: _formData["email"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
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
                controller: TextEditingController(text: _formData["id_proof"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Id Proof',
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
                    TextEditingController(text: _formData["id_proof_no"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Id Proof Number',
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
                    TextEditingController(text: formatDate(_formData["date_of_birth"]!)),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Date Of Birth',
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
                    TextEditingController(text: _formData["place_of_birth"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Place Of Birth',
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
                controller:
                    TextEditingController(text: _formData["occupation"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Occupation',
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
                controller:
                    TextEditingController(text: _formData["annual_income"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Annual Income',
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
                controller: TextEditingController(text: _formData["from_year"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'From Year',
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
                controller: TextEditingController(text: _formData["to_year"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'To Year',
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
                controller:
                    TextEditingController(text: _formData["marital_status"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Marital Status',
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
                controller:
                    TextEditingController(text: _formData["to_produce_at"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Purpose',
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
                controller: TextEditingController(text: _formData["purpose"]),
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'Purpose',
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
          ),
        ),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
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
                if (_fileMap["rationCard"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Ration Card (Self Attested)',
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
                      _buildPDFListItem(_fileMap["rationCard"]!, false),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["aadharCard"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Aadhar Card (Self Attested)',
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
                      _buildPDFListItem(_fileMap["aadharCard"]!, false),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["form16"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Form 16',
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
                      _buildPDFListItem(_fileMap["form16"]!, false),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["bankPassbook"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Bank PassBook(Pensioner)',
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
                      _buildPDFListItem(_fileMap["bankPassbook"]!, false),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["salaryCertificate"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Salary Certificate',
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
                      _buildPDFListItem(_fileMap["salaryCertificate"]!, false),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                if (_fileMap["selfDeclaration"] != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Self Declaration',
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
                      _buildPDFListItem(_fileMap["selfDeclaration"]!, false),
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
