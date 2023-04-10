import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum WidgetState { enabled, disabled }

class TradeLicense extends StatefulWidget {
  const TradeLicense({Key? key}) : super(key: key);

  @override
  _TradeLicenseState createState() => _TradeLicenseState();
}

class _TradeLicenseState extends State<TradeLicense> {
  int _currentStep = 0;
  bool isCompleted = false; //check completeness of inputs

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
            },
            onStepContinue: () {
              // _formKey.currentState!.validate();
              // _stepperKey.currentState.
              // bool isDetailValid = isDetailComplete(); //this check if ok to move on to next screen
              //
              // if (_formKey.currentState!.validate()) {
              //   if (isLastStep) {
              //     setState(() {
              //       isCompleted = true;
              //     });
              //   } else {
              //     setState(() {
              //       currentStep += 1;
              //     });
              //   }
              // }

              if (_currentStep == getSteps().length - 1) {
                // Perform submit operation
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

  bool _validateStep(int step) {
    return _formKeys[step].currentState?.validate() ?? false;
  }

  // // define the function to move to the next step
  // void next() {
  //   currentStep + 1 != getSteps().length ? goTo(currentStep + 1) : submit();
  // }

  bool isDetailComplete() {
    if (_currentStep == 0) {
      //check sender fields
      if (applicantPhoneNoController.text.isEmpty ||
          applicantAddressController.text.isEmpty ||
          applicantNameController.text.isEmpty ||
          applicantWardNoController.text.isEmpty ||
          applicantShopController.text.isEmpty) {
        return false;
      } else {
        return true; //if all fields are not empty
      }
    } else if (_currentStep == 1) {
      //check receiver fields
      if (applicantOwnerController.text.isEmpty ||
          applicantTradeController.text.isEmpty ||
          applicantTradeAddressController.text.isEmpty ||
          applicantRelationController.text.isEmpty ||
          applicantTypeofTradeController.text.isEmpty ||
          applicantBusinessController.text.isEmpty ||
          applicantTradeAreaController.text.isEmpty ||
          applicantEmployeesController.text.isEmpty ||
          //applicantWasteManagement.text.isEmpty ||
          // applicantLeasePay.text.isEmpty ||
          applicantSignContentOnBoardController.text.isEmpty ||
          applicantSignAreaController.text.isEmpty ||
          applicantSignLocationController.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return false;
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
            child: Column(
              children: const [Text('Information Complete!')],
            ),
          ),
        )
      ];
}
