import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TradeLicense extends StatefulWidget {
  const TradeLicense({Key? key}) : super(key: key);

  @override
  State<TradeLicense> createState() => _TradeLicenseState();
}

class _TradeLicenseState extends State<TradeLicense> {
  int currentStep = 0;
  bool isCompleted = false; //check completeness of inputs
  final formKey =
      GlobalKey<FormState>(); //form object to be used for form validation
  String dropdownValue = '---Select Signboard---';
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

  String? _selectedTaluka;
  String? _selectedVillage;
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
  TextEditingController applicantName = TextEditingController();
  TextEditingController applicantAddress = TextEditingController();
  TextEditingController applicantPhoneNo = TextEditingController();
  TextEditingController applicantWardNo = TextEditingController();
  TextEditingController applicantShop = TextEditingController();

  //sender details
  //final applicantPhoneNo = TextEditingController();
  //final applicantsAddress = TextEditingController();

  //receiver details
  TextEditingController applicantOwner = TextEditingController();
  TextEditingController applicantTrade = TextEditingController();
  TextEditingController applicantTradeAddress = TextEditingController();
  TextEditingController applicantRelation = TextEditingController();
  TextEditingController applicantTypeofTrade = TextEditingController();
  TextEditingController applicantBusiness = TextEditingController();
  TextEditingController applicantTradeArea = TextEditingController();
  TextEditingController applicantEmployees = TextEditingController();
  TextEditingController applicantWasteManagement = TextEditingController();
  TextEditingController applicantLeasePay = TextEditingController();

  //SignBoard
  TextEditingController applicantSignContentonBoard = TextEditingController();
  TextEditingController applicantSignArea = TextEditingController();
  TextEditingController applicantSignLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade License & Signboard'),
        backgroundColor: Color(0xffDDF0FF),
        foregroundColor: Color(0xff22215B),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff6CC51D),
          ),
        ),
        child: Form(
          key: formKey,
          child: Stepper(
            steps: getSteps(),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepTapped: (step) {
              formKey.currentState!.validate(); //this will trigger validation
              setState(() {
                currentStep = step;
              });
            },
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              formKey.currentState!.validate();
              bool isDetailValid =
                  isDetailComplete(); //this check if ok to move on to next screen

              if (isDetailValid) {
                if (isLastStep) {
                  setState(() {
                    isCompleted = true;
                  });
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              }
            },
            onStepCancel: () {
              if (currentStep == 0) {
                null;
              } else {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  bool isDetailComplete() {
    if (currentStep == 0) {
      //check sender fields
      if (applicantPhoneNo.text.isEmpty ||
          applicantAddress.text.isEmpty ||
          applicantName.text.isEmpty ||
          applicantWardNo.text.isEmpty ||
          applicantShop.text.isEmpty) {
        return false;
      } else {
        return true; //if all fields are not empty
      }
    } else if (currentStep == 1) {
      //check receiver fields
      if (applicantOwner.text.isEmpty ||
          applicantTrade.text.isEmpty ||
          applicantTradeAddress.text.isEmpty ||
          applicantRelation.text.isEmpty ||
          applicantTypeofTrade.text.isEmpty ||
          applicantBusiness.text.isEmpty ||
          applicantTradeArea.text.isEmpty ||
          applicantEmployees.text.isEmpty ||
          //applicantWasteManagement.text.isEmpty ||
          // applicantLeasePay.text.isEmpty ||
          applicantSignContentonBoard.text.isEmpty ||
          applicantSignArea.text.isEmpty ||
          applicantSignLocation.text.isEmpty) {
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
            title: const Text('Sender'),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
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
                            border:
                                Border.all(color: Color(0xffBDBDBD), width: 1)),
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
                        controller: applicantName,
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
                  controller: applicantAddress,
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
                    } else if (!RegExp(r"^[789]\d{9}$")
                        .hasMatch(value)) {
                      return "Invalid mobile no.";
                    }
                    // _phone= value;
                    // print("Phone : $_phone");
                    return null;
                  },
                  controller: applicantPhoneNo,
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
                        controller: applicantWardNo,
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
                        controller: applicantShop,
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
            )),
        Step(
            title: const Text('Receiver'),
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            content: Column(
              children: [
                SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantOwner,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Name of Owner * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantTrade,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Name of Trade * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantTradeAddress,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Trade Address * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantRelation,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Applican\'s relation * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantTypeofTrade,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Type of Trade * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantBusiness,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Nature of Business * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: applicantTradeArea,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Trade Area (sq.Mts) * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: applicantEmployees,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Number of Employees * ',
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
                  controller: applicantWasteManagement,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Waste Management faculty ',
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
                  controller: applicantLeasePay,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Lease Pay (Monthly, If Applicable) ',
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
                Text('Signboard Details',
                    style: TextStyle(
                        color: Colors.grey[800],
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 16),
                TextFormField(
                  controller: applicantSignLocation,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Signboard Location ',
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
                DropdownButtonFormField<String>(
                  value: dropdownValue,

                  items: <String>[
                    '---Select Signboard---',
                    'Cat',
                    'Tiger',
                    'Lion'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required*   ";
                    }
                    return null;
                  },
                  controller: applicantSignContentonBoard,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Content on Board * ',
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
                      return "Required*   ";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: applicantSignArea,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins-Bold',
                  ),
                  decoration: InputDecoration(
                    labelText: ' Area(sq.Ft)  *',
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
            )),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Complete'),
          content: Column(
            children: const [Text('Information Complete!')],
          ),
        )
      ];
}
