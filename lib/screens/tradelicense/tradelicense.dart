import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:open_file/open_file.dart';

enum WidgetState { enabled, disabled }

class TradeLicense extends StatefulWidget {
  const TradeLicense({Key? key}) : super(key: key);

  @override
  _TradeLicenseState createState() => _TradeLicenseState();
}

class _TradeLicenseState extends State<TradeLicense> {
  int _currentStep = 0;
  bool isCompleted = false; //check completeness of inputs

  final List<File?> _pdfFiles = List.generate(12, (_) => null);
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
  ];

  bool declaration = false;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final GlobalKey<State<StatefulWidget>> _stepperKey = GlobalKey();

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
    'WALL PAINTING',
    'NON-ILLUMINATED BOARD',
    'GLOW/NEON SIGNBOARD',
    'METALLIC ZINC BOARD',
    'ILLUMINATED BOARD',
    'FLEX BOARD',
    'GLOW BOARD',
    'WOODEN BOARD',
    'GLOW and BRANDED BOARD',
    'ARCYLIC BOARD',
  ];

  final List<String> _tradeTypes = [
    'Office ',
    'Fast Food ',
    'Restaurant ',
    'Bar and Restaurant ',
    'Tailoring ',
    'General Store ',
    'Super Market',
    'Wine Store',
    'Computer Shop ',
    'Mobile Shop ',
    'Garment Store',
    'Utensils Store ',
    'Sale of Two Wheeler ',
    'Sale of Four Wheeler ',
    'Hotels',
    'Sale of Vegetables and Fruits ',
    'Sale of Chicken ',
    'Sale of Shawrma',
    'Sale of Ross Omlet ',
    'Sale of Vada Paav',
    'Sale of Fish',
    'Bakery and Confectionary ',
    'Ice Cream Parlour',
    'Saloon ',
    'Beauty Parlour',
    'Pastry Shop ',
    'Fair Price Shop ',
    'Pharmacy ',
    'Clinics',
    'Pathology and Laboratory ',
    'Security Office ',
    'Open School ',
    'Play School for childrens',
    'Cement Godown',
    'Others',
  ];

  String? _selectedTaluka;
  String? _selectedVillage;
  String? _selectedSignboard;
  String? _selectedTypeOfTrade;

  List<DropdownMenuItem<String>> villageMenuItems = [];

  bool disabledVillageMenuItem = true;

  get controlsDetails => null;

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
  TextEditingController applicantAddressController = TextEditingController();
  TextEditingController applicantPhoneNoController = TextEditingController();
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

  WidgetState _widgetState =
      WidgetState.disabled; // for signboard details yes or no

  @override
  Widget build(BuildContext context) {
    print(_pdfFiles);

    return WillPopScope(
      onWillPop: () => _showCancelConfirmationDialog(context, false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Trade License & Signboard'),
          // backgroundColor: Color(0xffDDF0FF),
          backgroundColor: Color(0xffDAF5FF),
          foregroundColor: Color(0xff22215B),
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
              // if (step <= _currentStep) {
              //   setState(() {
              //     _currentStep = step;
              //   });
              // } else if (_validateStep(_currentStep) &&
              //     step == _currentStep + 1) {
              //   setState(() {
              //     _currentStep = step;
              //   });
              // }
              setState(() {
                _currentStep = step;
              });
            },
            onStepContinue: () {
              // if (_currentStep == getSteps().length - 1) {
              //   // Perform submit operation
              // } else if (_validateStep(_currentStep)) {
              //   setState(() {
              //     _currentStep += 1;
              //   });
              // }
              if (_currentStep == getSteps().length - 1) {
                // Perform submit operation
              } else {
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          backgroundColor: _currentStep == getSteps().length - 1
                              ? MaterialStateProperty.all<Color>(
                                  Color(0xff6CC51D))
                              : MaterialStateProperty.all<Color>(
                                  Color(0xFF5386E4)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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

  // bool _validateStep(int step) {
  //   return _formKeys[step].currentState?.validate() ?? false;
  // }

  // // define the function to move to the next step
  // void next() {
  //   currentStep + 1 != getSteps().length ? goTo(currentStep + 1) : submit();
  // }

  // bool isDetailComplete() {
  //   if (_currentStep == 0) {
  //     //check sender fields
  //     if (applicantPhoneNoController.text.isEmpty ||
  //         applicantAddressController.text.isEmpty ||
  //         applicantNameController.text.isEmpty ||
  //         applicantWardNoController.text.isEmpty ||
  //         applicantShopController.text.isEmpty) {
  //       return false;
  //     } else {
  //       return true; //if all fields are not empty
  //     }
  //   } else if (_currentStep == 1) {
  //     //check receiver fields
  //     if (applicantOwnerController.text.isEmpty ||
  //         applicantTradeController.text.isEmpty ||
  //         applicantTradeAddressController.text.isEmpty ||
  //         applicantRelationController.text.isEmpty ||
  //         applicantTypeofTradeController.text.isEmpty ||
  //         applicantBusinessController.text.isEmpty ||
  //         applicantTradeAreaController.text.isEmpty ||
  //         applicantEmployeesController.text.isEmpty ||
  //         //applicantWasteManagement.text.isEmpty ||
  //         // applicantLeasePay.text.isEmpty ||
  //         applicantSignContentOnBoardController.text.isEmpty ||
  //         applicantSignAreaController.text.isEmpty ||
  //         applicantSignLocationController.text.isEmpty) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                            labelText: "Applicant's Name ",
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
                  TextFormField(
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
                            return null;
                          },
                          controller: applicantWardNoController,
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
                            }
                            return null;
                          },
                          controller: applicantShopController,
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
            title: const Text('Trade'),
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    controller: applicantRelationController,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins-Bold',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Applicant\'s Relation',
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
                  Text('Do you want to enter Signboard Details?',
                      style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          color: Colors.black,
                          fontSize: 16)),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: WidgetState.enabled,
                              groupValue: _widgetState,
                              onChanged: (value) {
                                setState(() {
                                  _widgetState = value as WidgetState;
                                });
                              },
                            ),
                            const Text('YES'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: WidgetState.disabled,
                              groupValue: _widgetState,
                              onChanged: (value) {
                                setState(() {
                                  _widgetState = value as WidgetState;
                                });
                              },
                            ),
                            const Text('NO'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_widgetState == WidgetState.enabled) ...[
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
                        value: _selectedSignboard,
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
                            _selectedSignboard = newValue!;
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
          title: const Text('Documents'),
          content: Form(
            key: _formKeys[2],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upload Documents',
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
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
                      const Text(
                        'Identity Proof',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      if (_pdfFiles[0] != null) ...[
                        _buildPDFListItem(_pdfFiles[0]!)
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
                      const Text(
                        'Housetax Receipt',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      if (_pdfFiles[1] != null) ...[
                        _buildPDFListItem(_pdfFiles[1]!)
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
                      const Text(
                        'No Objection Certificate/ Lease argreement/ Ownership document',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 14,
                          color: Color(0xff21205b),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      if (_pdfFiles[2] != null) ...[
                        _buildPDFListItem(_pdfFiles[2]!)
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
                              value: _isChecked[0],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[0] = value!;
                                  _pdfFiles[3] = null;
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
                        visible: _isChecked[0],
                        child: _pdfFiles[3] != null
                            ? _buildPDFListItem(_pdfFiles[3]!)
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
                              value: _isChecked[1],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[1] = value!;
                                  _pdfFiles[4] = null;
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
                        visible: _isChecked[1],
                        child: _pdfFiles[4] != null
                            ? _buildPDFListItem(_pdfFiles[4]!)
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
                              value: _isChecked[2],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[2] = value!;
                                  _pdfFiles[5] = null;
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
                        visible: _isChecked[2],
                        child: _pdfFiles[5] != null
                            ? _buildPDFListItem(_pdfFiles[5]!)
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
                              value: _isChecked[3],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[3] = value!;
                                  _pdfFiles[6] = null;
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
                        visible: _isChecked[3],
                        child: _pdfFiles[6] != null
                            ? _buildPDFListItem(_pdfFiles[6]!)
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
                              value: _isChecked[4],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[4] = value!;
                                  _pdfFiles[7] = null;
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
                        visible: _isChecked[4],
                        child: _pdfFiles[7] != null
                            ? _buildPDFListItem(_pdfFiles[7]!)
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
                              value: _isChecked[5],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[5] = value!;
                                  _pdfFiles[8] = null;
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
                        visible: _isChecked[5],
                        child: _pdfFiles[8] != null
                            ? _buildPDFListItem(_pdfFiles[8]!)
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
                              value: _isChecked[6],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[6] = value!;
                                  _pdfFiles[9] = null;
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
                        visible: _isChecked[6],
                        child: _pdfFiles[9] != null
                            ? _buildPDFListItem(_pdfFiles[9]!)
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
                              value: _isChecked[7],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[7] = value!;
                                  _pdfFiles[10] = null;
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
                        visible: _isChecked[7],
                        child: _pdfFiles[10] != null
                            ? _buildPDFListItem(_pdfFiles[10]!)
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
                              value: _isChecked[8],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked[8] = value!;
                                  _pdfFiles[11] = null;
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
                        visible: _isChecked[8],
                        child: _pdfFiles[11] != null
                            ? _buildPDFListItem(_pdfFiles[11]!)
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
                          value: declaration,
                          onChanged: (bool? value) {
                            setState(() {
                              declaration = value!;
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
          await OpenFile.open(filePath);
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '${(pdfFile!.lengthSync() / 1024).toStringAsFixed(2)} KB',
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
                    int index = _pdfFiles.indexOf(pdfFile);
                    print(index);
                    _pdfFiles[index] = null;
                    print(_pdfFiles);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
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
          _pdfFiles[index] = File(result.files.single.path!);
        });
      }
    }
    print(_pdfFiles);
  }
}
