import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_panchayat_dev/models/register_request_model.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/main.dart';
import 'package:we_panchayat_dev/services/auth_api_service.dart';
import 'package:we_panchayat_dev/screens/auth/login.dart';

import 'package:intl/intl.dart';

import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../profile/profile_pic.dart';

class SignUp extends StatefulWidget {
  final String phone;

  // const SignUp({Key? key}) : super(key: key);

  SignUp({super.key, required this.phone});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isAPIcallProcess = false;

  bool _obscureTextPass = true;
  bool _obscureTextConfirm = true;

  final _formKey = GlobalKey<FormState>();

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

  final List<String> _validPinCodes = [
    '403001',
    '403002',
    '403003',
    '403004',
    '403005',
    '403006',
    '403101',
    '403104',
    '403107',
    '403108',
    '403109',
    '403110',
    '403114',
    '403174',
    '403201',
    '403202',
    '403206',
    '403401',
    '403404',
    '403405',
    '403406',
    '403407',
    '403409',
    '403410',
    '403502',
    '403503',
    '403504',
    '403506',
    '403507',
    '403508',
    '403509',
    '403512',
    '403513',
    '403514',
    '403515',
    '403516',
    '403517',
    '403518',
    '403519',
    '403521',
    '403523',
    '403524',
    '403527',
    '403530',
    '403531',
    '403601',
    '403602',
    '403603',
    '403604',
    '403701',
    '403702',
    '403703',
    '403704',
    '403706',
    '403707',
    '403708',
    '403710',
    '403711',
    '403712',
    '403713',
    '403715',
    '403716',
    '403717',
    '403718',
    '403721',
    '403722',
    '403724',
    '403725',
    '403726',
    '403728',
    '403731',
    '403801',
    '403802',
    '403803',
    '403806',
    '403808',
    '404102',
  ];

  final Map<String, String> _genderMap = {
    'Male': 'M',
    'Female': 'F',
    'Other': 'O',
  };

  String? _firstName;
  String? _lastName;
  String? _address;
  String? _pincode;
  String? _selectedGender;
  String? _selectedTaluka;
  String? _selectedVillage;
  DateTime _selectedDate = DateTime.now();
  String? _phone;
  String? _email;
  String _password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  void selectedGender(_value) {
    setState(() {
      _selectedGender = _value;

      print("Gender : $_selectedGender");
    });
  }

  void populateVillageMenuItem(List<String>? villages) {
    for (String village in villages!) {
      villageMenuItems.add(DropdownMenuItem<String>(
        child: Text(
          village,
          style: AuthConstants.getDropDownTextStyle(),
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

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;

    emailController.text = "";
    passwordController.text = "";

    debugPrint("Selected Two Taluka = $_selectedTaluka");
    debugPrint("Selected Two village = $_selectedVillage");

    return Container(
      padding: EdgeInsets.only(top: 60.0),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 0),
                      child: Image.asset(
                        'assets/images/icon.png',
                        height: 150.0,
                        width: 150.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 15.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Text(
                          'wE-Panchayat',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff21205b),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else if (!RegExp(r"^[789]\d{9}$")
                                        .hasMatch(value)) {
                                      return "Invalid mobile no.";
                                    }
                                    _phone = value;
                                    print("Phone : $_phone");
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(10),
                                  ],
                                  controller:
                                      TextEditingController(text: widget.phone),
                                  enabled: false,
                                  style: AuthConstants.getTextStyle(),
                                  decoration: InputDecoration(
                                    labelText: 'Mobile No.',
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    disabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
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
                                          _firstName = value;
                                          print("First Name : $_firstName");
                                          return null;
                                        },
                                        style: AuthConstants.getTextStyle(),
                                        decoration: InputDecoration(
                                          labelText: 'First Name',
                                          labelStyle: AuthConstants
                                              .getLabelAndHintStyle(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border:
                                              AuthConstants.getEnabledBorder(),
                                          enabledBorder:
                                              AuthConstants.getEnabledBorder(),
                                          focusedBorder:
                                              AuthConstants.getFocusedBorder(),
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
                                          _lastName = value;
                                          print("Last Name : $_lastName");
                                          return null;
                                        },
                                        style: AuthConstants.getTextStyle(),
                                        decoration: InputDecoration(
                                          labelText: 'Last Name',
                                          labelStyle: AuthConstants
                                              .getLabelAndHintStyle(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border:
                                              AuthConstants.getEnabledBorder(),
                                          enabledBorder:
                                              AuthConstants.getEnabledBorder(),
                                          focusedBorder:
                                              AuthConstants.getFocusedBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: AuthConstants
                                            .getDropDownBoxDecoration(),
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder
                                                .none, // Remove the bottom border
                                          ),
                                          menuMaxHeight: 200,
                                          isExpanded: true,
                                          icon: AuthConstants.getDropDownIcon(),
                                          value: _selectedTaluka,
                                          items: _mappedTalukaAndVillages.keys
                                              .map((String option) {
                                            return DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(
                                                option,
                                                style: AuthConstants
                                                    .getDropDownTextStyle(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (_value) =>
                                              selected(_value),
                                          hint: Text(
                                            "Select Taluka",
                                            style: AuthConstants
                                                .getDropDownHintStyle(),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: AuthConstants
                                            .getDropDownBoxDecoration(),
                                        child: DropdownButtonFormField(
                                          menuMaxHeight: 200,
                                          isExpanded: true,
                                          decoration: const InputDecoration(
                                            border: InputBorder
                                                .none, // Remove the bottom border
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.black,
                                          ),
                                          value: _selectedVillage,
                                          items: villageMenuItems,
                                          onChanged: disabledVillageMenuItem
                                              ? null
                                              : (_value) =>
                                                  secondselected(_value),
                                          disabledHint: Text(
                                            "Select Village",
                                            style: AuthConstants
                                                .getDropDownHintStyle(),
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
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    _address = value;
                                    print("Address : $_address");
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
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
                                          } else if (value.length < 6 ||
                                              !_validPinCodes.contains(value)) {
                                            return "Enter a valid Pin Code";
                                          }
                                          _pincode = value;
                                          print("Pin Code : $_pincode");
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          new LengthLimitingTextInputFormatter(
                                              6),
                                        ],
                                        style: AuthConstants.getTextStyle(),
                                        decoration: InputDecoration(
                                          labelText: 'Pin Code',
                                          labelStyle: AuthConstants
                                              .getLabelAndHintStyle(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border:
                                              AuthConstants.getEnabledBorder(),
                                          enabledBorder:
                                              AuthConstants.getEnabledBorder(),
                                          focusedBorder:
                                              AuthConstants.getFocusedBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: AuthConstants
                                            .getDropDownBoxDecoration(),
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder
                                                .none, // Remove the bottom border
                                          ),
                                          menuMaxHeight: 200,
                                          isExpanded: true,
                                          icon: AuthConstants.getDropDownIcon(),
                                          value: _selectedGender,
                                          items:
                                              _genderMap.keys.map((String option) {
                                            return DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(
                                                option,
                                                style: AuthConstants
                                                    .getDropDownTextStyle(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (_value) =>
                                              selectedGender(_value),
                                          hint: Text(
                                            "Gender",
                                            style: AuthConstants
                                                .getDropDownHintStyle(),
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration:
                                      AuthConstants.getDropDownBoxDecoration(),
                                  child: ListTile(
                                    title: Text(
                                      "Date Of Birth:    ${DateFormat('dd-MM-yyyy').format(_selectedDate)}",
                                      style: AuthConstants.getTextStyle(),
                                    ),
                                    trailing: AuthConstants.getCalenderIcon(),
                                    onTap: _pickDate,
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
                                    _email = value;
                                    print("Email : $_email");
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else if (!isPasswordValid(value)) {
                                      return "Password must have:\n"
                                          "At least 8 characters long.\n"
                                          "At least one uppercase letter.\n"
                                          "At least one lowercase letter.\n"
                                          "At least one number.\n"
                                          "At least one special character.";
                                    }
                                    _password = value;
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  obscureText: _obscureTextPass,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureTextPass = !_obscureTextPass;
                                        });
                                      },
                                      child: Icon(
                                        _obscureTextPass
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    suffixIconColor:
                                        ColorConstants.formLabelTextColor,
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else if (!isPasswordValid(value)) {
                                      return "Password must have:\n"
                                          "At least 8 characters long.\n"
                                          "At least one uppercase letter.\n"
                                          "At least one lowercase letter.\n"
                                          "At least one number.\n"
                                          "At least one special character.";
                                    } else if (value != _password) {
                                      return "Passwords do not match.";
                                    }
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  obscureText: _obscureTextConfirm,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureTextConfirm =
                                              !_obscureTextConfirm;
                                        });
                                      },
                                      child: Icon(
                                        _obscureTextConfirm
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    suffixIconColor:
                                        ColorConstants.formLabelTextColor,
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // String _dob = "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}";

                      String dob =
                          DateFormat('dd-MM-yyyy').format(_selectedDate);

                      print("DOB actual : ${_selectedDate}");
                      print("DOB : $dob");
                      print("Taluka : $_selectedTaluka");
                      print("Village : $_selectedVillage");
                      print("Gender : $_selectedGender");

                      setState(() {
                        isAPIcallProcess = true;
                      });

                      RegisterRequestModel model = RegisterRequestModel(
                        email: _email,
                        password: _password,
                        fullname: '$_firstName $_lastName',
                        address: _address,
                        pincode: _pincode,
                        phone: _phone,
                        gender: _genderMap[_selectedGender],
                        taluka: _selectedTaluka,
                        village: _selectedVillage,
                        dateofbirth: dob,
                      );

                      var response = await APIService.register(model);

                      if(response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Registered successfully. Welcome to wE-Panchayat.')));



                        var jsonResponse = jsonDecode(response.body);

                        int id = jsonResponse['id'];

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePicturePage(userId: id, mongoId: "NA", isSignup: true,)),
                              (route) => false,
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to Register.')));
                      }
                    }
                  },
                  child: Text("Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Bold',
                      )),
                  // style: ElevatedButton.styleFrom(
                  //   primary: Color(0xFF5386E4),
                  //   onPrimary: Colors.white,
                  //   shape: StadiumBorder(),
                  //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  // ),
                  style: AuthConstants.getSubmitButtonStyle(),
                ),
              ),
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Divider(
            //       height: 1,
            //       thickness: 0.8,
            //       color: Colors.black54,
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //       child: GestureDetector(
            //         child: Text(
            //           "Already have an account? Log in",
            //           style: TextStyle(
            //             color: Color(0xFF5386E4),
            //             fontWeight: FontWeight.w700,
            //             fontSize: 15,
            //             fontFamily: 'Poppins-Bold',
            //           ),
            //           // Your bottom element goes here
            //         ),
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => Login()),
            //           );
            //         },
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

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

  bool isPasswordValid(String password) {
    // Check if password is at least 8 characters long
    if (password.length < 8) {
      return false;
    }

    // Check if password contains at least one uppercase letter
    if (password.toLowerCase() == password) {
      return false;
    }

    // Check if password contains at least one lowercase letter
    if (password.toUpperCase() == password) {
      return false;
    }

    // Check if password contains at least one number
    if (!password.contains(new RegExp(r'[0-9]'))) {
      return false;
    }

    // Check if password contains at least one special character
    if (!password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    // If all checks pass, the password is valid
    return true;
  }
}
