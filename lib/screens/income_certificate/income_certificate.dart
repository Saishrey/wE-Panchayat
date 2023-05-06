import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:we_panchayat_dev/screens/application_submitted.dart';
import 'package:we_panchayat_dev/services/income_certificate_api_service.dart';

import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';

enum MaritalStatus { married, unmarried }

class IncomeCertificate extends StatefulWidget {
  final Map<String, File?>? fileMap;
  final Map<String, String>? formData;
  final bool isEdit;

  const IncomeCertificate(
      {Key? key, this.fileMap, this.formData, required this.isEdit})
      : super(key: key);

  @override
  State<IncomeCertificate> createState() => _IncomeCertificateState();
}

class _IncomeCertificateState extends State<IncomeCertificate> {
  int _currentStep = 0;
  final String pdfFileExtension = 'pdf';
  final String imageFileExtension = 'jpeg';
  final int _maxFileSize = 2 * 1024 * 1024;

  bool isCompleted = false; //check completeness of inputs

  Map<String, File> _fileMap = {};

  final List<String> _fileNames = [
    "rationCard",
    "aadharCard",
    "file3",
    "selfDeclaration",
    "photo",
  ];

  final List<GlobalKey<FormState>> _formKeys = [
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
  final List<String> _idProof = [
    "Voter Id",
    "Pan Card",
    "Aadhar Card",
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
  final List<String> _titleDropdownList = [
    "Mr",
    "Mrs",
    "Master",
    "Miss",
  ];

  final Map<String, String> _file3TypeMap = {
    "Form 16" : "form16",
    "Salary Certificate" : "salaryCertificate",
    "Bank Passbook" : "bankPassbook",
  };

  String? _selectedIdProof;
  String? _selectedApplicantRelation;
  String? _selectedTitle;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTaluka;
  String? _selectedVillage;
  String? _selectedMaritalStatus = "Unmarried";
  String? _selectedFile3Type = "Form 16";

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
  TextEditingController applicantGuardianNameController =
      TextEditingController();
  TextEditingController applicantPhoneNoController = TextEditingController();
  TextEditingController applicantEmailController = TextEditingController();
  TextEditingController applicantIdProofNumberController =
      TextEditingController();
  TextEditingController applicantPlaceOfBirthController =
      TextEditingController();
  TextEditingController applicantRelationOfController = TextEditingController();
  TextEditingController applicantAddressController = TextEditingController();
  TextEditingController applicantOccupationController = TextEditingController();
  TextEditingController applicantAnnualIncomeController =
      TextEditingController();
  TextEditingController applicantAnnualIncomeFromYearController =
      TextEditingController();
  TextEditingController applicantAnnualIncomeToYearController =
      TextEditingController();
  TextEditingController applicantProduceAtController = TextEditingController();
  TextEditingController applicantPurposeController = TextEditingController();

  MaritalStatus _maritalStatus =
      MaritalStatus.unmarried;


  String fileType = 'All';

  FilePickerResult? result;
  PlatformFile? file;

  @override
  void initState() {
    if(widget.isEdit) {
      // Dropdown details
      _selectedTaluka = widget.formData!["taluka"];
      selected(_selectedTaluka);
      disabledVillageMenuItem = false;
      _selectedVillage = widget.formData!["panchayat"];

      _selectedIdProof = widget.formData!["id_proof"];
      _selectedApplicantRelation = widget.formData!["applicants_relation"];
      _selectedTitle = widget.formData!["title"];
      _selectedDate = DateTime.parse(widget.formData!["date_of_birth"]!);
      _selectedMaritalStatus = widget.formData!["marital_status"];

      for(var entry in _file3TypeMap.entries) {
        if(widget.fileMap!.containsKey(entry.value)) {
          _selectedFile3Type = entry.key;
          print(_selectedFile3Type);
          break;
        }
      }

      applicantNameController = TextEditingController(text: widget.formData!["applicants_name"]);
      applicantGuardianNameController = TextEditingController(text: widget.formData!["parents_name"]);
      applicantPhoneNoController = TextEditingController(text: widget.formData!["phone"]);
      applicantEmailController = TextEditingController(text: widget.formData!["email"]);
      applicantIdProofNumberController = TextEditingController(text: widget.formData!["id_proof_no"]);
      applicantPlaceOfBirthController = TextEditingController(text: widget.formData!["place_of_birth"]);
      applicantRelationOfController = TextEditingController(text: widget.formData!["applicants_relation"]);
      applicantAddressController = TextEditingController(text: widget.formData!["applicants_address"]);
      applicantOccupationController = TextEditingController(text: widget.formData!["occupation"]);
      applicantAnnualIncomeController = TextEditingController(text: widget.formData!["annual_income"]);
      applicantAnnualIncomeFromYearController = TextEditingController(text: widget.formData!["from_year"]);
      applicantAnnualIncomeToYearController = TextEditingController(text: widget.formData!["to_year"]);
      applicantProduceAtController = TextEditingController(text: widget.formData!["to_produce_at"]);
      applicantPurposeController = TextEditingController(text: widget.formData!["purpose"]);

      //Documents
      for (int i = 0; i < _fileNames.length; i++) {
        if(i==2) {
          _fileMap[_fileNames[i]] = widget.fileMap![_file3TypeMap[_selectedFile3Type]!]!;
        }
        else {
          _fileMap[_fileNames[i]] = widget.fileMap![_fileNames[i]]!;
        }
      }

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
      applicantEmailController =
          TextEditingController(text: loginResponseModel?.email);
    });
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

  @override
  Widget build(BuildContext context) {
    print("FILE MAP : $_fileMap");
    // print(_selectedTitle);
    // print(_selectedMaritalStatus);
    // print(_selectedFile3Type);

    return WillPopScope(
      onWillPop: () => _showCancelConfirmationDialog(context, false),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? 'Edit form' : 'Income Certificate',
            style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,),
          ),
          backgroundColor: Color(0xffFAD4D4),
          foregroundColor: Color(0xffF45656),
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
                }
                // setState(() {
                //   _currentStep = step;
                // });
              },
              onStepContinue: () async {
                // if (_currentStep == getSteps().length - 1) {
                //   // Perform submit operation
                // } else if (_validateStep(_currentStep)) {
                //   setState(() {
                //     _currentStep += 1;
                //   });
                // }
                if (_currentStep == getSteps().length - 1) {
                  // Perform submit operation
                  if (_fileMap.length < 5) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Please upload the required documents.')));
                  } else {
                    Map<String, String> body = {
                      "taluka": _selectedTaluka!,
                      "panchayat": _selectedVillage!,
                      "title": _selectedTitle!,
                      "applicants_name": applicantNameController.text,
                      "applicants_address": applicantAddressController.text,
                      "phone": applicantPhoneNoController.text,
                      "email": applicantEmailController.text,
                      "parents_name": applicantGuardianNameController.text,
                      "id_proof": _selectedIdProof!,
                      "id_proof_no": applicantIdProofNumberController.text,
                      "date_of_birth":
                          DateFormat('dd-MM-yyyy').format(_selectedDate),
                      "place_of_birth": applicantPlaceOfBirthController.text,
                      "applicants_relation": _selectedApplicantRelation!,
                      "occupation": applicantOccupationController.text,
                      "annual_income": applicantAnnualIncomeController.text,
                      "from_year": applicantAnnualIncomeFromYearController.text,
                      'to_year': applicantAnnualIncomeToYearController.text,
                      "marital_status": _selectedMaritalStatus!,
                      "to_produce_at": applicantProduceAtController.text,
                      "purpose": applicantPurposeController.text,
                    };

                    http.Response response;

                    if(widget.isEdit) {
                      print("APPLICATION ID: ${widget.formData!["application_id"]!}");
                      body["application_id"] = widget.formData!["application_id"]!;
                      response = await IncomeCertificateAPIService.updateForm(body);
                    }
                    else {
                      response = await IncomeCertificateAPIService.saveForm(body);
                    }


                    if (response.statusCode == 200) {
                      print(
                          "Income certificate Form Data Successfully Submitted.");
                      String? newKeyFile3 = _file3TypeMap[_selectedFile3Type!];
                      bool isSuccessful;

                      if(widget.isEdit) {
                        //update files
                        isSuccessful = await IncomeCertificateAPIService.updateFiles({..._fileMap}, newKeyFile3!, widget.formData!["mongo_id"]!);
                      } else {
                        //upload files
                        Map<String, dynamic> map = jsonDecode(response.body);
                        String applicationId = map['application_id'];
                        print(applicationId);

                        isSuccessful = await IncomeCertificateAPIService.uploadFiles({..._fileMap}, newKeyFile3!, applicationId);
                      }


                      if (isSuccessful) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplicationSubmitted()),
                          (route) => false,
                        );
                      } else {
                        print("Failed to upload documents INCOME CERTIFICATE");
                      }
                    } else {
                      print("Failed to Submit Income Certificate Form.");
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
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                          onPressed: controlsDetails.onStepContinue,
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
                                    ? MaterialStateProperty.all<Color>(
                                        Color(0xff6CC51D))
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
              }),
        ),
      ),
    );
  }

  bool _validateStep(int step) {
    switch (step) {
      case 0:
        if (_formKeys[0].currentState?.validate() ?? false) {
          print("Applicant Details");
          print(_selectedTaluka);
          print(_selectedVillage);
          print(_selectedTitle);
          print(applicantNameController.text);
          print(applicantGuardianNameController.text);
          print(applicantPhoneNoController.text);
          print(applicantEmailController.text);
          print(_selectedIdProof);
          print(applicantIdProofNumberController.text);
          print(applicantPlaceOfBirthController.text);
          print(_selectedDate);
          print(_selectedApplicantRelation);
          print(applicantRelationOfController.text);
          print(applicantAddressController.text);
          print(applicantOccupationController.text);
          print(applicantAnnualIncomeController.text);
          print(applicantAnnualIncomeFromYearController.text);
          print(applicantAnnualIncomeToYearController.text);
          print(applicantProduceAtController.text);
          print(applicantPurposeController.text);

          return true;
        }
        return false;
      case 2:
        return _formKeys[step].currentState?.validate() ?? false;
      default:
        return _formKeys[step].currentState?.validate() ?? false;
    }
  }

  //This will be your screens
  List<Step> getSteps() => [
        Step(
            title: const Text('Applicant'),
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
                  SizedBox(
                    height: 16,
                  ),
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
                      value: _selectedTitle,
                      items: _titleDropdownList.map((String option) {
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
                          _selectedTitle = newValue!;
                        });
                      },
                      hint: Text(
                        "Title",
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantGuardianNameController,
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
                      } else if (!RegExp(r"^[789]\d{9}$").hasMatch(value)) {
                        return "Invalid mobile no.";
                      }
                      //   _phone = value;
                      //    print("Phone : $_phone");
                      return null;
                    },
                    enabled: false,
                    controller: applicantPhoneNoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins-Bold',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Mobile',
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Invalid email";
                      }
                      //   _email = value;
                      //  print("Email : $_email");
                      return null;
                    },
                    controller: applicantEmailController,
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
                            value: _selectedIdProof,
                            items: _idProof.map((String option) {
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
                                _selectedIdProof = newValue!;
                              });
                            },
                            hint: Text(
                              "Id Proof",
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
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            // else if (!RegExp(r"^[789]\d{9}$")
                            //     .hasMatch(value)) {
                            //   return "Invalid  .";
                            // }
                            //   _phone = value;
                            //    print("Phone : $_phone");
                            return null;
                          },
                          controller: applicantIdProofNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(12),
                          ],
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffBDBDBD), width: 1)),
                    child: ListTile(
                      title: Text(
                        "Date Of Birth:    ${DateFormat('dd-MM-yyyy').format(_selectedDate)}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      trailing: Icon(Icons.calendar_month),
                      onTap: _pickDate,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required   ";
                      }
                      return null;
                    },
                    controller: applicantPlaceOfBirthController,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins-Bold',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Place of Birth',
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
                            value: _selectedApplicantRelation,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedApplicantRelation = newValue!;
                              });
                            },
                            hint: Text(
                              "Relation",
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
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          controller: applicantRelationOfController,
                          style: TextStyle(
                            color: Colors.black54, //Name
                            fontFamily: 'Poppins-Bold',
                          ),
                          decoration: InputDecoration(
                            labelText: "Of",
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
                  SizedBox(height: 16),
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
                      labelText: 'Address',
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
                    controller: applicantOccupationController,
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
                    controller: applicantAnnualIncomeController,
                    keyboardType: TextInputType.number,
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
                            }
                            else if (!RegExp(r"\b(19\d{2}|20\d{2})\b")
                                .hasMatch(value)) {
                              return "Invalid  .";
                            }
                            return null;
                          },
                          controller: applicantAnnualIncomeFromYearController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          style: TextStyle(
                            color: Colors.black54, //Name
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
                            }
                            else if (!RegExp(r"\b(19\d{2}|20\d{2})\b")
                                .hasMatch(value)) {
                              return "Invalid  .";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          controller: applicantAnnualIncomeToYearController,
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
                  Text(
                    'Marital Status',
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
                              value: MaritalStatus.married,
                              groupValue: _maritalStatus,
                              onChanged: (value) {
                                setState(() {
                                  _maritalStatus = value as MaritalStatus;
                                  _selectedMaritalStatus = "Married";
                                });
                              },
                            ),
                            const Text(
                              'Married',
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
                              value: MaritalStatus.unmarried,
                              groupValue: _maritalStatus,
                              onChanged: (value) {
                                setState(() {
                                  _maritalStatus = value as MaritalStatus;
                                  _selectedMaritalStatus = "Unmarried";
                                });
                              },
                            ),
                            const Text(
                              'Unmarried',
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
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantProduceAtController,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins-Bold',
                    ),
                    decoration: InputDecoration(
                      labelText: 'To produce at',
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
                    controller: applicantPurposeController,
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            )),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: const Text('Documents'),
          content: Form(
            key: _formKeys[1],
            child: Column(
              children: [
                const Text(
                  'Upload Documents',
                  style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                    if (_fileMap.containsKey(_fileNames[0])) ...[
                      _buildPDFListItem(_fileMap[_fileNames[0]]!, false)
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
                    if (_fileMap.containsKey(_fileNames[1])) ...[
                      _buildPDFListItem(_fileMap[_fileNames[1]]!, false)
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
                            'Form 16/ Salary Certificate/ Bank PassBook(Pensioner)',
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
                    DropdownButtonFormField(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(5),
                      icon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.black,
                      ),
                      value: _selectedFile3Type,
                      items: _file3TypeMap.keys.map((String option) {
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
                          _selectedFile3Type = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          // Add validation to check if a value is selected
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_fileMap.containsKey(_fileNames[2])) ...[
                      _buildPDFListItem(_fileMap[_fileNames[2]]!, false)
                    ] else ...[
                      chooseFileButton(2)
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
                            'Self Declaration',
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
                    if (_fileMap.containsKey(_fileNames[3])) ...[
                      _buildPDFListItem(_fileMap[_fileNames[3]]!, false)
                    ] else ...[
                      chooseFileButton(3)
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
                            'Photo: (in JPEG File Format)',
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
                    if (_fileMap.containsKey(_fileNames[4])) ...[
                      _buildPDFListItem(_fileMap[_fileNames[4]]!, true)
                    ] else ...[
                      chooseFileButton(4)
                    ],
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ];

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime(1950).year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: _selectedDate,
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Widget chooseFileButton(int index) {
    return ElevatedButton(
      onPressed: () async {
        if (index == 4) {
          _pickFile(index, imageFileExtension);
        } else {
          _pickFile(index, pdfFileExtension);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF5386E4)),
      ),
      child: const Text('Choose file'),
    );
  }

  void _pickFile(int index, String fileExtension) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [fileExtension],
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
          _fileMap[_fileNames[index]] = File(result.files.single.path!);
        });
      }
    }
    print(_fileMap);
  }

  Widget _buildPDFListItem(File file, bool isImage) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () async {

          String filePath = file.path;
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
                      ),
                      Text(
                        '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB',
                        style: TextStyle(
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
                    String key = getKeyFromValue(file);
                    _fileMap.remove(key);
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
}
