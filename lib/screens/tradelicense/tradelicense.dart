import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:we_panchayat_dev/models/login_response_model.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import 'package:we_panchayat_dev/services/trade_license_api_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:open_file/open_file.dart';

import '../application_submitted.dart';

enum SignboardDetails { enabled, disabled }

class TradeLicense extends StatefulWidget {
  final Map<String, File?>? fileMap;
  final Map<String, String>? formData;
  final bool isEdit;

  const TradeLicense(
      {Key? key, this.fileMap, this.formData, required this.isEdit})
      : super(key: key);

  @override
  _TradeLicenseState createState() => _TradeLicenseState();
}

class _TradeLicenseState extends State<TradeLicense> {
  int _currentStep = 0;
  bool isCompleted = false; //check completeness of inputs

  Map<String, File> _fileMap = {};

  final int _maxFileSize = 2 * 1024 * 1024;

  final List<bool> _isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final List<String> _fileNames = [
    "identityProof",
    "houseTax",
    "ownershipDocument",
    "permissionsGranted.foodAndDrugs",
    "permissionsGranted.excise",
    "permissionsGranted.policeDepartment",
    "permissionsGranted.crz",
    "permissionsGranted.tourism",
    "permissionsGranted.fireAndBridge",
    "permissionsGranted.factoriesAndBoilers",
    "permissionsGranted.healthServices",
    "permissionsGranted.others.file",
  ];

  bool _isCheckedDeclaration = false;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final Map<String, List<String>> _mappedTalukaAndVillages = {
    'Bardez': [
      'Aldona',
      'Anjuna',
      'Arpora-Nagoa',
      'Assagao',
      'Assanora',
      'Bastora',
      'Calangute',
      'Camurlim',
      'Candolim',
      'Colvale',
      'Guirim',
      'Moira',
      'Nachinola',
      'Nadora',
      'Nerul',
      'Oxel',
      'Parra',
      'Penha-De-Franca',
      'Pilerne',
      'Pirna',
      'Pomburpa-Olaulim',
      'Reis Magos',
      'Revora',
      'Saligao',
      'Salvador-Do-Mundo',
      'Sangolda',
      'Siolim-Marna',
      'Siolim-Sodiem',
      'Sirsaim',
      'Socorro',
      'Tivim',
      'Ucassaim,Paliem-Punola',
      'Verla Canca',
    ],
    'Bicholim': [
      'Advalpal',
      'Amona',
      'Cudnem',
      'Harvalem',
      'Karapur-Sarvan',
      'Latambarcem',
      'Maulinguem',
      'Mayem',
      'Mencurem',
      'Mulgao',
      'Naroa',
      'Navelim,Bicholim',
      'Pale,Cotombi',
      'Piligao',
      'Salem',
      'Sirigao',
      'Surla',
      'Velguem',
    ],
    'Canacona': [
      'Agonda',
      'Cola',
      'Cotigao',
      'Gaondongri',
      'Loliem-Polem',
      'Poinguinim',
      'Shristhal'
    ],
    'Dharbandora': [
      'Colem',
      'Dharbandora',
      'Kirlapal-Dabhal',
      'Mollem',
      'Sancordem',
    ],
    'Mormugao': [
      'Cansaulim-Arossim-Cuelim',
      'Chicalim',
      'Chicolna-Bogmalo',
      'Cortalim',
      'Majorda-Utorda-Calata',
      'Nagoa',
      'Quelossim',
      'Sancoale',
      'Velsao-Pale',
      'Verna',
    ],
    'Pernem': [
      'Agarwada,Chopdem',
      'Alorna',
      'Arambol',
      'Casnem, Amberem,Poroscodem',
      'Chandel Hassapur',
      'Corgao',
      'Dhargal',
      'Ibrampur',
      'Kasarvanem',
      'Mandrem',
      'Morjim',
      'Ozarim',
      'Paliem',
      'Parcem',
      'Querim-Tiracol',
      'Tamboxem,Mopa,Uguem',
      'Torxem',
      'Tuem',
      'Varkhand Nagzar',
      'Virnoda',
    ],
    'Ponda': [
      'Bandora',
      'Betora-Nirancal',
      'Betqui, Candola',
      'Bhoma-Adcolna',
      'Borim',
      'Curti-Khandepar',
      'Durbhat',
      'Kundaim',
      'Marcaim',
      'Panchawadi',
      'Quela',
      'Querim',
      'Shiroda',
      'Talaulim',
      'Tivrem-Orgao',
      'Usgao-Ganjem',
      'Veling,Priol,Cuncoliem',
      'Verem,Vaghurme',
      'Volvoi',
    ],
    'Quepem': [
      'Ambaulim',
      'Assolda',
      'Avedem-Cotombi',
      'Balli-Adnem',
      'Barcem',
      'Caurem',
      'Fatorpa-Quitol',
      'Molcornem',
      'Morpirla',
      'Naqueri-Betul',
      'Xeldem',
    ],
    'Salcete': [
      'Ambelim',
      'Aquem Baixo',
      'Assolna',
      'Benaulim',
      'Betalbatim',
      'Camorlim',
      'Carmona',
      'Cavelossim',
      'Chandor-Cavorim',
      'Chinchinim- Deussua',
      'Colva',
      'Curtorim',
      'Davorlim,Dicarpale',
      'Dramapur',
      'Guirdolim',
      'Loutulim',
      'Macasana',
      'Navelim Salcete',
      'Nuvem',
      'Orlim',
      'Paroda',
      'Rachol',
      'Raia',
      'Rumdamol-Davorlim',
      'Sarzora',
      'Seraulim',
      'St. Jose-De-Areal',
      'Telaulim',
      'Varca',
      'Velim',
    ],
    'Sanguem': [
      'Bhati',
      'Curdi',
      'Kalay(Kalem)',
      'Neturlim',
      'Rivona',
      'Sanvordem(Sanguem)',
      'Uguem',
    ],
    'Sattari': [
      'Birondem',
      'Cotorem',
      'Dongurli',
      'Guleli',
      'Honda',
      'Kerim',
      'Mauxi',
      'Morlem',
      'Nagargao',
      'Pissurlem',
      'Poriem',
      'Sanvordem(Sattari)',
    ],
    'Tiswadi': [
      'Batim',
      'Carambolim',
      'Chimbel',
      'Chodan-Madel',
      'Corlim',
      'Cumbharjua',
      'Curca,Bambolim,Talaulim',
      'Goltim-Navelim',
      'Merces',
      'Neura',
      'Sao Lourence(Agassaim)',
      'Sao Matias',
      'Se-Old-Goa',
      'Siridao-Palem',
      'St. Andre',
      'St. Cruz',
      'St. Estevam',
      'Taleigao',
    ],
  };

  final List<String> _signboardValues = [
    "Wall Painting",
    "Non-Illuminated Board",
    "Glow/Neon Signboard",
    "Metallic Zinc Board",
    "Illuminated Board",
    "Flex Board",
    "Glow Board",
    "Wooden Board",
    "Glow And Branded Board",
    "Acrylic Board",
  ];

  final List<String> _tradeTypes = [
    "Office",
    "Fast Food",
    "Restaurant",
    "Bar and Restaurant",
    "Tailoring",
    "General Store",
    "Super Market",
    "Wine Store",
    "Garment Store",
    "Utensils Store",
    "Computer Shop",
    "Mobile Shop",
    "Sale of Two Wheeler",
    "Sale of Four Wheeler",
    "Hotels",
    "Sale of Vegetables and Fruits",
    "Sale of Chicken",
    "Sale of Shawrma",
    "Sale of Ross Omlet",
    "Sale of Vada Paav",
    "Sale of Fish",
    "Bakery and Confectionary",
    "Ice Cream Parlour",
    "Saloon",
    "Beauty Parlour",
    "Pastry Shop",
    "Fair Price Shop",
    "Pharmacy",
    "Clinics",
    "Pathology and Laboratory",
    "Security Office",
    "Open School",
    "Play School for childrens",
    "Cement Godown",
    "Others",
  ];

  final List<String> _applicantsRelation = [
    "Self",
    "Son",
    "Daughter",
    "Mother",
    "Father",
    "Wife",
    "Husband",
    "Son-In-Law",
    "Daughter-In-Law",
    "Mother-In-Law",
    "Father-In-Law",
    "Brother-In-Law",
    "Sister-In-Law",
    "Others",
  ];

  String? _selectedTaluka;
  String? _selectedVillage;
  String? _selectedSignboardType;
  String? _selectedTypeOfTrade;
  String? _selectedRelationType;

  List<DropdownMenuItem<String>> villageMenuItems = [];

  bool disabledVillageMenuItem = true;

  void selected(_value) {
    villageMenuItems = [];
    populateVillageMenuItem(_mappedTalukaAndVillages[_value]);
    setState(() {
      _selectedTaluka = _value;

      _selectedVillage = _mappedTalukaAndVillages[_value]![0];

      debugPrint("Selected One Taluka = $_selectedTaluka");
      debugPrint("Selected One village = $_selectedVillage");

      disabledVillageMenuItem = false;
    });
  }

  void populateVillageMenuItem(List<String>? villages) {
    for (String village in villages!) {
      villageMenuItems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(village,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Poppins-Bold',
              )),
        ),
        value: village,
      ));
    }
  }

  void secondselected(_value) {
    setState(() {
      _selectedVillage = _value;
      debugPrint("Selected Two Taluka = $_selectedTaluka");
      debugPrint("Selected Two village = $_selectedVillage");
    });
  }

  //form1
  TextEditingController applicantNameController = TextEditingController();
  TextEditingController applicantPhoneNoController = TextEditingController();
  TextEditingController applicantAddressController = TextEditingController();

  TextEditingController applicantWardNoController = TextEditingController();
  TextEditingController applicantShopController = TextEditingController();

  //sender details
  //final applicantPhoneNo = TextEditingController();
  //final applicantsAddress = TextEditingController();

  //receiver details
  TextEditingController applicantOwnerController = TextEditingController();
  TextEditingController applicantTradeController = TextEditingController();
  TextEditingController applicantTradeAddressController =
      TextEditingController();
  TextEditingController applicantRelationController = TextEditingController();
  TextEditingController applicantTypeofTradeController =
      TextEditingController();
  TextEditingController applicantBusinessController = TextEditingController();
  TextEditingController applicantTradeAreaController = TextEditingController();
  TextEditingController applicantEmployeesController = TextEditingController();
  TextEditingController applicantWasteManagementController =
      TextEditingController();
  TextEditingController applicantLeasePayController = TextEditingController();

  //SignBoard
  TextEditingController applicantSignContentOnBoardController =
      TextEditingController();
  TextEditingController applicantSignAreaController = TextEditingController();
  TextEditingController applicantSignLocationController =
      TextEditingController();

  SignboardDetails _signboardDetails =
      SignboardDetails.disabled; // for signboard details yes or no

  @override
  void initState() {
    if (widget.isEdit) {
      // Dropdown details
      _selectedTaluka = widget.formData!["taluka"];
      selected(_selectedTaluka);
      disabledVillageMenuItem = false;
      _selectedVillage = widget.formData!["panchayat"];

      _selectedSignboardType = widget.formData!["signboard_type"];
      _selectedTypeOfTrade = widget.formData!["trade_type"];
      _selectedRelationType = widget.formData!["applicants_relation"];

      // Step 1 details
      applicantNameController =
          TextEditingController(text: widget.formData!["applicants_name"]);
      applicantPhoneNoController =
          TextEditingController(text: widget.formData!["phone"]);
      applicantAddressController =
          TextEditingController(text: widget.formData!["applicants_address"]);
      applicantWardNoController =
          TextEditingController(text: widget.formData!["ward_no"]);
      applicantShopController =
          TextEditingController(text: widget.formData!["shop_no"]);

      //Step 2 details
      applicantOwnerController =
          TextEditingController(text: widget.formData!["owner_name"]);
      applicantTradeController =
          TextEditingController(text: widget.formData!["trade_name"]);
      applicantTradeAddressController =
          TextEditingController(text: widget.formData!["trade_address"]);
      applicantRelationController =
          TextEditingController(text: widget.formData!["applicants_relation"]);
      applicantTypeofTradeController =
          TextEditingController(text: widget.formData!["trade_type"]);
      applicantBusinessController =
          TextEditingController(text: widget.formData!["business_nature"]);
      applicantTradeAreaController =
          TextEditingController(text: widget.formData!["trade_area"]);
      applicantEmployeesController =
          TextEditingController(text: widget.formData!["no_of_employee"]);
      applicantWasteManagementController = TextEditingController(
          text: widget.formData!["waste_management_facility"]);
      applicantLeasePayController =
          TextEditingController(text: widget.formData!["lease_pay"]);

      //SignBoard
      if (widget.formData!["signboard_details"] == "true") {
        _signboardDetails = SignboardDetails.enabled;
      }
      applicantSignContentOnBoardController =
          TextEditingController(text: widget.formData!["signboard_content"]);
      applicantSignAreaController =
          TextEditingController(text: widget.formData!["signboard_area"]);
      applicantSignLocationController =
          TextEditingController(text: widget.formData!["signboard_location"]);

      //Documents
      for (int i = 0; i < _fileNames.length; i++) {
        if (widget.fileMap!.containsKey(_fileNames[i])) {
          _fileMap[_fileNames[i]] = widget.fileMap![_fileNames[i]]!;
          _isChecked[i] = true;
        }
      }

      //Declaration
      _isCheckedDeclaration = true;
    } else {
      initialiseNamePhoneAddress();
    }
  }

  Future<void> initialiseNamePhoneAddress() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    setState(() {
      applicantNameController =
          TextEditingController(text: loginResponseModel?.fullname);
      applicantPhoneNoController =
          TextEditingController(text: loginResponseModel?.phone);
      applicantAddressController =
          TextEditingController(text: loginResponseModel?.address);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_pdfFiles);
    print(widget.fileMap);
    print(widget.formData);
    print(_isChecked);
    print(applicantNameController.text);
    print(applicantPhoneNoController.text);
    print(applicantAddressController.text);

    return WillPopScope(
      onWillPop: () => _showCancelConfirmationDialog(context, false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xffDAF5FF),
          foregroundColor: Color(0xff415EB6),
          title: Text(
            widget.isEdit ? 'Edit form' : 'Trade License & Signboard',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 18,
            ),
          ),
          elevation: 0,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff6CC51D),
            ),
          ),
          child: Stepper(
            steps: getSteps(),
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepTapped: (step) {
              if (step <= _currentStep) {
                setState(() {
                  _currentStep = step;
                });
              } else if (_validateStep(_currentStep) &&
                  step == _currentStep + 1) {
                setState(() {
                  _currentStep = step;
                });
              } else if (_validateStep(0) &&
                  _validateStep(1) &&
                  _validateStep(2)) {
                setState(() {
                  _currentStep = step;
                });
              }
              // setState(() {
              //   _currentStep = step;
              // });
            },
            onStepContinue: () async {
              if (_currentStep == getSteps().length - 1) {
                // Perform submit operation
                if (!_isChecked[0] || !_isChecked[1] || !_isChecked[2]) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Please upload the required documents.')));
                } else {
                  Map<String, String> body = {
                    "taluka": _selectedTaluka!,
                    "panchayat": _selectedVillage!,
                    "applicants_name": applicantNameController.text,
                    "applicants_address": applicantAddressController.text,
                    "phone": applicantPhoneNoController.text,
                    "ward_no": applicantWardNoController.text,
                    "shop_no": applicantShopController.text,
                    "owner_name": applicantOwnerController.text,
                    "trade_name": applicantTradeController.text,
                    "trade_address": applicantTradeAddressController.text,
                    "applicants_relation": _selectedRelationType!,
                    "trade_type": _selectedTypeOfTrade!,
                    "business_nature": applicantBusinessController.text,
                    "waste_management_facility":
                        applicantWasteManagementController.text,
                    "lease_pay": applicantLeasePayController.text,
                    'trade_area': applicantTradeAreaController.text,
                    "no_of_employee": applicantEmployeesController.text,
                    "signboard_details":
                        (_signboardDetails == SignboardDetails.enabled)
                            .toString(),
                    "signboard_location":
                        applicantSignLocationController.text,
                    "signboard_type": _selectedSignboardType ?? "",
                    "signboard_content":
                        applicantSignContentOnBoardController.text,
                    "signboard_area": applicantSignAreaController.text,
                  };

                  http.Response response;

                  if (widget.isEdit) {
                    print(
                        "APPLICATION ID: ${widget.formData!["application_id"]!}");
                    print(
                        "SIGNBOARD ID: ${widget.formData!["signboard_id"]!}");

                    body["application_id"] =
                        widget.formData!["application_id"]!;
                    body["signboard_id"] =
                        widget.formData!["signboard_id"]!;

                    response =
                        await TradeLicenseAPIService.updateForm(body);
                  } else {
                    response = await TradeLicenseAPIService.saveForm(body);
                  }

                  if (response.statusCode == 200) {
                    print(
                        "Trade License Form Data Successfully Submitted.");

                    bool isSuccessful;

                    if (widget.isEdit) {
                      //update files
                      isSuccessful =
                          await TradeLicenseAPIService.updateFiles(
                              {..._fileMap}, widget.formData!["mongo_id"]!);
                    } else {
                      //upload files
                      Map<String, dynamic> map = jsonDecode(response.body);
                      String applicationId = map['applicationId'];
                      print(applicationId);
                      isSuccessful =
                          await TradeLicenseAPIService.uploadFiles(
                              {..._fileMap}, applicationId);
                    }

                    if (isSuccessful) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicationSubmitted()),
                        (route) => false,
                      );
                    } else {
                      print("Failed to upload documents TRADE LICENSE");
                    }
                  } else {
                    print("Failed to Submit Trade License Form.");
                  }
                }
              } else if (_validateStep(_currentStep)) {
                setState(() {
                  _currentStep += 1;
                });
              }
            },
            onStepCancel: () {
              if (_currentStep == 0) {
                _showCancelConfirmationDialog(context, true);
              } else {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
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
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controlsDetails.onStepCancel,
                        child: Text(
                          _currentStep == 0 ? 'Cancel' : 'Back',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Colors.black54,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black54),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(top: 15.0, bottom: 15.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _currentStep == getSteps().length - 1
                            ? (_isCheckedDeclaration
                                ? controlsDetails.onStepContinue
                                : null)
                            : controlsDetails.onStepContinue,
                        child: Text(
                          _currentStep + 1 == getSteps().length
                              ? 'Submit'
                              : 'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              _currentStep == getSteps().length - 1
                                  ? (_isCheckedDeclaration
                                      ? MaterialStateProperty.all<Color>(
                                          Color(0xff6CC51D))
                                      : MaterialStateProperty.all<Color>(
                                          Colors.grey))
                                  : MaterialStateProperty.all<Color>(
                                      Color(0xFF5386E4)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(top: 15.0, bottom: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _showCancelConfirmationDialog(
      BuildContext context, bool isCancel) async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to cancel?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                if (isCancel) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop(false);
                }
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                if (isCancel) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  bool _validateStep(int step) {
    switch (step) {
      case 0:
        if (_formKeys[0].currentState?.validate() ?? false) {
          print("Applicant Details");
          print(_selectedTaluka);
          print(_selectedVillage);
          print(applicantNameController.text);
          print(applicantAddressController.text);
          print(applicantPhoneNoController.text);
          print(applicantWardNoController.text);
          print(applicantShopController.text);

          return true;
        }
        return false;
      case 1:
        if (_formKeys[1].currentState?.validate() ?? false) {
          print("Trade Details");
          print(applicantOwnerController.text);
          print(applicantTradeController.text);
          print(applicantTradeAddressController.text);
          print(_applicantsRelation);
          print(_selectedTypeOfTrade);
          print(applicantBusinessController.text);
          print(applicantWasteManagementController.text);
          print(applicantLeasePayController.text);
          print(applicantTradeAreaController.text);
          print(applicantEmployeesController.text);

          print("Signboard Details");
          print(applicantSignLocationController.text);
          print(_selectedSignboardType);
          print(applicantSignContentOnBoardController.text);
          print(applicantSignAreaController.text);

          return true;
        }
        return false;
      case 3:
        return _formKeys[step].currentState?.validate() ?? false;
      default:
        return _formKeys[step].currentState?.validate() ?? false;
    }
  }

  //This will be your screens
  List<Step> getSteps() => [
        Step(
            title: const Text(
              'Applicant',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                color: Colors.black54,
              ),
            ),
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 0,
            content: Form(
              key: _formKeys[0],
              child: Column(
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
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color(0xffBDBDBD), width: 1)),
                          child: DropdownButtonFormField(
                            menuMaxHeight: 200,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                            ),
                            value: _selectedTaluka,
                            items: _mappedTalukaAndVillages.keys
                                .map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (_value) => selected(_value),
                            hint: Text(
                              "Taluka",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Poppins-Bold',
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                // Add validation to check if a value is selected
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color(0xffBDBDBD), width: 1)),
                          child: DropdownButtonFormField(
                            menuMaxHeight: 200,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                            ),
                            value: _selectedVillage,
                            items: villageMenuItems,
                            onChanged: disabledVillageMenuItem
                                ? null
                                : (_value) => secondselected(_value),
                            disabledHint: Text(
                              "Panchayat",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Poppins-Bold',
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                // Add validation to check if a value is selected
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // getFormField("Applicant's Name"),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantNameController,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantAddressController,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      } else if (!RegExp(r"^[789]\d{9}$").hasMatch(value)) {
                        return "Invalid mobile no.";
                      }
                      // _phone= value;
                      // print("Phone : $_phone");
                      return null;
                    },
                    controller: applicantPhoneNoController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                    ],
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
                      disabledBorder: OutlineInputBorder(
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            } else if (!RegExp(r"^\d+$").hasMatch(value)) {
                              return "Invalid Ward No.";
                            }
                            return null;
                          },
                          controller: applicantWardNoController,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            } else if (!RegExp(r"^\d+$").hasMatch(value)) {
                              return "Invalid Shop No.";
                            }
                            return null;
                          },
                          controller: applicantShopController,
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
              ),
            )),
        Step(
            title: const Text(
              'Trade',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                color: Colors.black54,
              ),
            ),
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 1,
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: [
                  Text('Trade Details',
                      style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          color: Colors.black,
                          fontSize: 20)),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantOwnerController,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantTradeController,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantTradeAddressController,
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffBDBDBD), width: 1)),
                    child: DropdownButtonFormField(
                      menuMaxHeight: 200,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.black,
                      ),
                      items: _applicantsRelation.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Poppins-Bold',
                            ),
                          ),
                        );
                      }).toList(),
                      value: _selectedRelationType,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRelationType = newValue!;
                        });
                      },
                      hint: Text(
                        "Applicant's Relation",
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          // Add validation to check if a value is selected
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffBDBDBD), width: 1)),
                    child: DropdownButtonFormField(
                      menuMaxHeight: 200,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.black,
                      ),
                      items: _tradeTypes.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Poppins-Bold',
                            ),
                          ),
                        );
                      }).toList(),
                      value: _selectedTypeOfTrade,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTypeOfTrade = newValue!;
                        });
                      },
                      hint: Text(
                        "Type of Trade",
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          // Add validation to check if a value is selected
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantBusinessController,
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
                    controller: applicantWasteManagementController,
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
                    controller: applicantLeasePayController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins-Bold',
                    ),
                    decoration: InputDecoration(
                      labelText: ' Lease Pay (Monthly, if Applicable) ',
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: applicantTradeAreaController,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: applicantEmployeesController,
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Do you want to enter Signboard Details?',
                    style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: SignboardDetails.enabled,
                              groupValue: _signboardDetails,
                              onChanged: (value) {
                                setState(() {
                                  _signboardDetails = value as SignboardDetails;
                                });
                              },
                            ),
                            const Text(
                              'YES',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  color: Colors.black54,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: SignboardDetails.disabled,
                              groupValue: _signboardDetails,
                              onChanged: (value) {
                                setState(() {
                                  _signboardDetails = value as SignboardDetails;
                                });
                              },
                            ),
                            const Text(
                              'NO',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  color: Colors.black54,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_signboardDetails == SignboardDetails.enabled) ...[
                    // This widget will only be shown if the radio button for "enabled" is selected.
                    SizedBox(height: 16),
                    Text('Signboard Details',
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            color: Colors.black,
                            fontSize: 20)),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: applicantSignLocationController,
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
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0xffBDBDBD), width: 1)),
                      child: DropdownButtonFormField(
                        menuMaxHeight: 200,
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.black,
                        ),
                        value: _selectedSignboardType,
                        items: _signboardValues.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Poppins-Bold',
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSignboardType = newValue!;
                          });
                        },
                        hint: Text(
                          "Select Signboard",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins-Bold',
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            // Add validation to check if a value is selected
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: applicantSignContentOnBoardController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: applicantSignAreaController,
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
            )),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: const Text(
            'Documents',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              color: Colors.black54,
            ),
          ),
          content: Form(
            key: _formKeys[2],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Upload Documents',
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  const Text(
                    '(Please upload documents in .pdf format. File size not to exceed 2MB)',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                      if (_fileMap.containsKey(_fileNames[0])) ...[
                        _buildPDFListItem(_fileMap[_fileNames[0]]!)
                      ] else ...[
                        chooseFileButton(0)
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                      if (_fileMap.containsKey(_fileNames[1])) ...[
                        _buildPDFListItem(_fileMap[_fileNames[1]]!)
                      ] else ...[
                        chooseFileButton(1)
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                      if (_fileMap.containsKey(_fileNames[2])) ...[
                        _buildPDFListItem(_fileMap[_fileNames[2]]!)
                      ] else ...[
                        chooseFileButton(2)
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Please upload permissions granted by the Authorities as per requirement',
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[3],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[3] = value!;
                                  // _pdfFiles[3] = null;
                                  _fileMap.remove(_fileNames[3]);
                                });
                              }),
                          const Text(
                            "Foods & Drugs",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[3],
                        // child: _pdfFiles[3] != null
                        //     ? _buildPDFListItem(_pdfFiles[3]!)
                        //     : chooseFileButton(3),
                        child: _fileMap.containsKey(_fileNames[3])
                            ? _buildPDFListItem(_fileMap[_fileNames[3]]!)
                            : chooseFileButton(3),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[4],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[4] = value!;
                                  // _pdfFiles[4] = null;
                                  _fileMap.remove(_fileNames[4]);
                                });
                              }),
                          const Text(
                            "Excise",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[4],
                        // child: _pdfFiles[4] != null
                        //     ? _buildPDFListItem(_pdfFiles[4]!)
                        //     : chooseFileButton(4),
                        child: _fileMap.containsKey(_fileNames[4])
                            ? _buildPDFListItem(_fileMap[_fileNames[4]]!)
                            : chooseFileButton(4),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[5],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[5] = value!;
                                  // _pdfFiles[5] = null;
                                  _fileMap.remove(_fileNames[5]);
                                });
                              }),
                          const Text(
                            "Police Dept.",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[5],
                        // child: _pdfFiles[5] != null
                        //     ? _buildPDFListItem(_pdfFiles[5]!)
                        //     : chooseFileButton(5),
                        child: _fileMap.containsKey(_fileNames[5])
                            ? _buildPDFListItem(_fileMap[_fileNames[5]]!)
                            : chooseFileButton(5),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[6],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[6] = value!;
                                  // _pdfFiles[6] = null;
                                  _fileMap.remove(_fileNames[6]);
                                });
                              }),
                          const Text(
                            "CRZ",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[6],
                        // child: _pdfFiles[6] != null
                        //     ? _buildPDFListItem(_pdfFiles[6]!)
                        //     : chooseFileButton(6),
                        child: _fileMap.containsKey(_fileNames[6])
                            ? _buildPDFListItem(_fileMap[_fileNames[6]]!)
                            : chooseFileButton(6),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[7],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[7] = value!;
                                  // _pdfFiles[7] = null;
                                  _fileMap.remove(_fileNames[7]);
                                });
                              }),
                          const Text(
                            "Tourism",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[7],
                        // child: _pdfFiles[7] != null
                        //     ? _buildPDFListItem(_pdfFiles[7]!)
                        //     : chooseFileButton(7),
                        child: _fileMap.containsKey(_fileNames[7])
                            ? _buildPDFListItem(_fileMap[_fileNames[7]]!)
                            : chooseFileButton(7),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[8],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[8] = value!;
                                  // _pdfFiles[8] = null;
                                  _fileMap.remove(_fileNames[8]);
                                });
                              }),
                          const Text(
                            "Fire Brigade",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[8],
                        // child: _pdfFiles[8] != null
                        //     ? _buildPDFListItem(_pdfFiles[8]!)
                        //     : chooseFileButton(8),
                        child: _fileMap.containsKey(_fileNames[8])
                            ? _buildPDFListItem(_fileMap[_fileNames[8]]!)
                            : chooseFileButton(8),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[9],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[9] = value!;
                                  // _pdfFiles[9] = null;
                                  _fileMap.remove(_fileNames[9]);
                                });
                              }),
                          const Text(
                            "Factories & Boilers",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[9],
                        // child: _pdfFiles[9] != null
                        //     ? _buildPDFListItem(_pdfFiles[9]!)
                        //     : chooseFileButton(9),
                        child: _fileMap.containsKey(_fileNames[9])
                            ? _buildPDFListItem(_fileMap[_fileNames[9]]!)
                            : chooseFileButton(9),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[10],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[10] = value!;
                                  // _pdfFiles[10] = null;
                                  _fileMap.remove(_fileNames[10]);
                                });
                              }),
                          const Text(
                            "Health Services",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[10],
                        // child: _pdfFiles[10] != null
                        //     ? _buildPDFListItem(_pdfFiles[10]!)
                        //     : chooseFileButton(10),
                        child: _fileMap.containsKey(_fileNames[10])
                            ? _buildPDFListItem(_fileMap[_fileNames[10]]!)
                            : chooseFileButton(10),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[11],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[11] = value!;
                                  // _pdfFiles[11] = null;
                                  _fileMap.remove(_fileNames[11]);
                                });
                              }),
                          const Text(
                            "Others",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 14,
                              color: Color(0xff21205b),
                            ), // or TextOverflow.fade
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isChecked[11],
                        // child: _pdfFiles[11] != null
                        //     ? _buildPDFListItem(_pdfFiles[11]!)
                        //     : chooseFileButton(11),
                        child: _fileMap.containsKey(_fileNames[11])
                            ? _buildPDFListItem(_fileMap[_fileNames[11]]!)
                            : chooseFileButton(11),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Self Declaration",
                      style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _isCheckedDeclaration,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckedDeclaration = value!;
                            });
                          }),
                      const Expanded(
                        child: Text(
                          "I declare that the above information is true to the best of my knowledge and belief. I am well aware that information given by me above is proved false/not true, I will have to face the punishment as per law & also all the permissions obtained by me shall be summarily withdrawn.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              overflow: TextOverflow.visible),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        )
      ];

  Widget _buildPDFListItem(File pdfFile) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () async {
          String filePath = pdfFile.path;
          var r = await OpenFile.open(filePath);
          print("MESSAGE: ${r.message}");
        },
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
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Color(0xFF5386E4),
                ),
                // onPressed: () {},
                onPressed: () {
                  setState(() {
                    String key = getKeyFromValue(pdfFile);
                    _fileMap.remove(key);

                    int index = _fileNames.indexOf(key);
                    _isChecked[index] = false;

                    print(_fileMap);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getKeyFromValue(File targetFile) {
    for (var entry in _fileMap.entries) {
      if (entry.value == targetFile) {
        return entry.key;
      }
    }
    return "null"; // no key found for the value
  }

  Widget chooseFileButton(int index) {
    return ElevatedButton(
      onPressed: () async {
        _pickFile(index);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF5386E4)),
      ),
      child: const Text('Choose file'),
    );
  }

  void _pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      if (file.size > _maxFileSize) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('File too large'),
            content: Text('Selected file is larger than 2 MB.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          if (0 <= index && index <= 2) {
            _isChecked[index] = true;
          }
          _fileMap[_fileNames[index]] = File(result.files.single.path!);
        });
      }
    }
    print(_fileMap);
  }
}
