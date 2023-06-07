import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/services/birth_and_death_certificate_api_service.dart';
import '../../constants.dart';

class BirthAndDeathCertificate extends StatefulWidget {
  BirthAndDeathCertificate({Key? key}) : super(key: key);

  @override
  _BirthAndDeathCertificateState createState() =>
      _BirthAndDeathCertificateState();
}

class _BirthAndDeathCertificateState extends State<BirthAndDeathCertificate>
    with SingleTickerProviderStateMixin {
  TextEditingController applicantName = TextEditingController();
  TextEditingController applicantGuardianName = TextEditingController();
  TextEditingController mobile = TextEditingController();

  final _birthCertificateFormKey = GlobalKey<FormState>();
  final _deathCertificateFormKey = GlobalKey<FormState>();

  final List<String> _panchayatList = [
    "Advalpal",
    "Agarwada,Chopdem",
    "Agonda",
    "Aldona",
    "Alorna",
    "Ambaulim",
    "Ambelim",
    "Amona",
    "Anjuna",
    "Aquem Baixo",
    "Arambol",
    "Arpora-Nagoa",
    "Assagao",
    "Assanora",
    "Assolda",
    "Assolna",
    "Avedem-Cotombi",
    "Azossim-Mandur",
    "Balli-Adnem",
    "Bandora",
    "Barcem",
    "Bastora",
    "Batim",
    "Benaulim",
    "Betalbatim",
    "Betora-Nirancal",
    "Betqui, Candola",
    "Bhati",
    "Bhoma-Adcolna",
    "Birondem",
    "Borim",
    "Calangute",
    "Camurlim",
    "Camorlim",
    "Candolim",
    "Carambolim",
    "Carmona",
    "Casnem, Amberem,Poroscodem",
    "Caurem",
    "Cavelossim",
    "Chandel",
    "Chandor-Cavorim",
    "Chicalim",
    "Chicolna-Bogmalo",
    "Chimbel",
    "Chinchinim- Deussua",
    "Chodan-Madel",
    "Cola",
    "Colem",
    "Colva",
    "Colvale",
    "Corgao",
    "Corlim",
    "Cortalim",
    "Cotigao",
    "Cotorem",
    "Cudnem",
    "Cansaulim-Arossim-Cuelim",
    "Cumbharjua",
    "Curca,Bambolim,Talaulim",
    "Curdi",
    "Curti-Khandepar",
    "Curtorim",
    "Davorlim,Dicarpale",
    "Dharbandora",
    "Dhargal",
    "Dongurli",
    "Dramapur",
    "Durbhat",
    "Fatorpa-Quitol",
    "Gaondongri",
    "Goltim-Navelim",
    "Guirdolim",
    "Guirim",
    "Guleli",
    "Honda",
    "Ibrampur",
    "Kalay(Kalem)",
    "Karapur-Sarvan",
    "Kasarvanem",
    "Querim-Tiracol",
    "Kerim",
    "Kirlapal-Dabhal",
    "Kundaim",
    "Latambarcem",
    "Loliem-Polem",
    "Loutulim",
    "Macasana",
    "Majorda",
    "Mandrem",
    "Marcaim",
    "Maulinguem",
    "Mauxi",
    "Mayem",
    "Mencurem",
    "Merces",
    "Moira",
    "Molcornem",
    "Mollem",
    "Morjim",
    "Morlem",
    "Morpirla",
    "Mulgao",
    "Nachinola",
    "Nadora",
    "Nagargao",
    "Nagoa",
    "Naqueri-Betul",
    "Naroa",
    "Navelim,Bicholim",
    "Navelim Salcete",
    "Nerul",
    "Neturlim",
    "Neura",
    "Nuvem",
    "Orlim",
    "Oxel",
    "Ozarim",
    "Pale,Cotombi",
    "Paliem",
    "Panchawadi",
    "Parcem",
    "Paroda",
    "Parra",
    "Penha-De-Franca",
    "Pilerne",
    "Piligao",
    "Pirna",
    "Pissurlem",
    "Poinguinim",
    "Pomburpa-Olaulim",
    "Poriem",
    "Quela",
    "Querim",
    "Rachol",
    "Raia",
    "Revora",
    "Rivona",
    "Rumdamol-Davorlim",
    "Salem",
    "Saligao",
    "Salvador-Do-Mundo",
    "Sancoale",
    "Sancordem",
    "Sangolda",
    "Taleigao",
    "Sanvordem(Sattari)",
    "Sanvordem(Sanguem)",
    "Sao Lourence(Agassaim)",
    "Sao Matias",
    "Sarzora",
    "Se-Old-Goa",
    "Seraulim",
    "Shiroda",
    "Shristhal",
    "Siolim-Marna",
    "Siolim-Sodiem",
    "Siridao-Palem",
    "Sirigao",
    "Sirsaim",
    "Socorro",
    "St. Andre",
    "St. Cruz",
    "St. Estevam",
    "St. Jose-De-Areal",
    "Surla",
    "Talaulim",
    "Tamboxem,Mopa,Uguem",
    "Telaulim",
    "Tivim",
    "Tivrem-Orgao",
    "Torxem",
    "Tuem",
    "Ucassaim,Palem",
    "Uguem",
    "Usgao-Ganjem",
    "Varca",
    "Varkhand Nagzar",
    "Velguem",
    "Velim",
    "Veling,Priol,Cuncoliem",
    "Velsao-Pale",
    "Reis Magos",
    "Verem,Vaghurme",
    "Verla Canca",
    "Verna",
    "Virnoda",
    "Volvoi",
    "Xeldem",
    "Harvalem",
    "Quelossim",
  ];

  List<DropdownMenuItem<String>> villageMenuItems = [];

  String? _selectedPanchayatBirth;
  DateTime _selectedDateOfBirth = DateTime.now();
  TextEditingController birthRegistrationNumberController =
      TextEditingController();
  TextEditingController birthApplicantNameController = TextEditingController();
  TextEditingController birthApplicantFatherNameController =
      TextEditingController();
  TextEditingController birthApplicantMotherNameController =
      TextEditingController();

  String? _selectedPanchayatDeath;
  DateTime _selectedDateOfDeath = DateTime.now();
  TextEditingController deathRegistrationNumberController =
      TextEditingController();
  TextEditingController deathApplicantNameController = TextEditingController();
  TextEditingController deathApplicantFatherNameController =
      TextEditingController();

  final Color _darkBlueButton = const Color(0xff356899);

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Birth Certificate'),
    const Tab(text: 'Death Certificate'),
  ];

  // Define the TabController
  TabController? _tabController;

  bool disabledVillageMenuItem = true;

  Future<bool> _showCancelConfirmationDialog(
      BuildContext context, bool isCancel) async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Are you sure you want to cancel?', style: AlertDialogBoxConstants.getNormalTextStyle(),),
          actions: <Widget>[
            TextButton(
              child: Text('No', style: AlertDialogBoxConstants.getButtonTextStyle(),),
              onPressed: () {
                if (isCancel) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop(false);
                }
              },
            ),
            TextButton(
              child: Text('Yes', style: AlertDialogBoxConstants.getButtonTextStyle(),),
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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showCancelConfirmationDialog(context, false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xffFBFACD),
          foregroundColor: Color(0xffFFB110),
          title: Text(
            ' Birth & Death Certificates',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 18,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Color(0xffFBFACD),
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
                        'Birth Certificate',
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
                        'Death Certificate',
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _birthCertificateFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Birth Certificate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: ColorConstants.darkBlueThemeColor,
                                    fontSize: 20),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: FormConstants.getDropDownBoxDecoration(),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 200,
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder
                                        .none, // Remove the bottom border
                                  ),
                                  icon: FormConstants.getDropDownIcon(),
                                  value: _selectedPanchayatBirth,
                                  items: _panchayatList.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                          style: FormConstants.getDropDownTextStyle(),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (_value) {
                                    _selectedPanchayatBirth = _value.toString();
                                  },
                                  hint: Text(
                                    "Panchayat",
                                    style: FormConstants.getDropDownHintStyle(),
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
                              const SizedBox(height: 16),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  else if(!RegExp(
                                      r"^\w{1,}(\/[A-Za-z0-9]+)*$")
                                      .hasMatch(value)) {
                                    return "Invalid Registration No.";
                                  }
                                  return null;
                                },
                                controller: birthRegistrationNumberController,
                                style: FormConstants.getTextStyle(),
                                decoration: InputDecoration(
                                  labelText: 'Registration Number',
                                  labelStyle: FormConstants.getLabelAndHintStyle(),
                                  // filled: true,
                                  // fillColor: Color(0xffF6F6F6),
                                  border: FormConstants.getEnabledBorder(),
                                  enabledBorder: FormConstants.getEnabledBorder(),
                                  focusedBorder: FormConstants.getFocusedBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                controller: birthApplicantNameController,
                                style: FormConstants.getTextStyle(),
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: FormConstants.getLabelAndHintStyle(),
                                  // filled: true,
                                  // fillColor: Color(0xffF6F6F6),
                                  border: FormConstants.getEnabledBorder(),
                                  enabledBorder: FormConstants.getEnabledBorder(),
                                  focusedBorder: FormConstants.getFocusedBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      controller:
                                          birthApplicantFatherNameController,
                                      style: FormConstants.getTextStyle(),
                                      decoration: InputDecoration(
                                        labelText: 'Father\'s Name ',
                                        labelStyle: FormConstants.getLabelAndHintStyle(),
                                        // filled: true,
                                        // fillColor: Color(0xffF6F6F6),
                                        border: FormConstants.getEnabledBorder(),
                                        enabledBorder: FormConstants.getEnabledBorder(),
                                        focusedBorder: FormConstants.getFocusedBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                controller:
                                    birthApplicantMotherNameController,
                                style: FormConstants.getTextStyle(),
                                decoration: InputDecoration(
                                  labelText: 'Mother\'s Name',
                                  labelStyle: FormConstants.getLabelAndHintStyle(),
                                  // filled: true,
                                  // fillColor: Color(0xffF6F6F6),
                                  border: FormConstants.getEnabledBorder(),
                                  enabledBorder: FormConstants.getEnabledBorder(),
                                  focusedBorder: FormConstants.getFocusedBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: FormConstants.getDropDownBoxDecoration(),
                                child: ListTile(
                                  title: Text(
                                    "Date Of Birth:    ${DateFormat('dd-MM-yyyy').format(_selectedDateOfBirth)}",
                                    style: FormConstants.getTextStyle(),
                                  ),
                                  trailing: FormConstants.getCalenderIcon(),
                                  onTap: _pickDateOfBirth,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedPanchayatBirth = null;
                                          birthRegistrationNumberController
                                              .clear();
                                          birthApplicantNameController.clear();
                                          birthApplicantFatherNameController
                                              .clear();
                                          birthApplicantMotherNameController
                                              .clear();
                                          _selectedDateOfBirth = DateTime.now();
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            side: BorderSide(
                                              color: ColorConstants.formLabelTextColor,
                                            ),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Bold',
                                          color: ColorConstants.formLabelTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // Validate the form inputs
                                        if (_birthCertificateFormKey
                                            .currentState!
                                            .validate()) {
                                          // Form is valid, do something here
                                          print('Form is valid!');

                                          Map<String, String> birthBody = {
                                            "panchayat":
                                                _selectedPanchayatBirth!,
                                            "registration_no":
                                                birthRegistrationNumberController
                                                    .text,
                                            "name": birthApplicantNameController
                                                .text,
                                            "date_of_birth":
                                                DateFormat('dd-MM-yyyy').format(
                                                    _selectedDateOfBirth),
                                            "father_name":
                                                birthApplicantFatherNameController
                                                    .text,
                                            "mother_name":
                                                birthApplicantMotherNameController
                                                    .text,
                                          };

                                          var response = await BirthAndDeathCertificateAPIService.getBirthCertificate(birthBody);

                                          if(response.statusCode != 200) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Record does not exist.'),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Search',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Bold',
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            ColorConstants.submitGreenColor),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
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
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _deathCertificateFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Death Certificate',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: ColorConstants.darkBlueThemeColor,
                                    fontSize: 20),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: FormConstants.getDropDownBoxDecoration(),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 200,
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder
                                        .none, // Remove the bottom border
                                  ),
                                  icon: FormConstants.getDropDownIcon(),
                                  value: _selectedPanchayatDeath,
                                  items: _panchayatList.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: FormConstants.getDropDownTextStyle(),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (_value) {
                                    _selectedPanchayatDeath = _value.toString();
                                  },
                                  hint: Text(
                                    "Panchayat",
                                    style: FormConstants.getDropDownHintStyle(),
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
                              const SizedBox(height: 16),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  else if(!RegExp(
                                      r"^\w{1,}(\/[A-Za-z0-9]+)*$")
                                      .hasMatch(value)) {
                                    return "Invalid Registration No.";
                                  }
                                  return null;
                                },
                                controller: deathRegistrationNumberController,
                                style: FormConstants.getTextStyle(),
                                decoration: InputDecoration(
                                  labelText: 'Registration Number',
                                  labelStyle: FormConstants.getLabelAndHintStyle(),
                                  // filled: true,
                                  // fillColor: Color(0xffF6F6F6),
                                  border: FormConstants.getEnabledBorder(),
                                  enabledBorder: FormConstants.getEnabledBorder(),
                                  focusedBorder: FormConstants.getFocusedBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                controller: deathApplicantNameController,
                                style: FormConstants.getTextStyle(),
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: FormConstants.getLabelAndHintStyle(),
                                  // filled: true,
                                  // fillColor: Color(0xffF6F6F6),
                                  border: FormConstants.getEnabledBorder(),
                                  enabledBorder: FormConstants.getEnabledBorder(),
                                  focusedBorder: FormConstants.getFocusedBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                controller: deathApplicantFatherNameController,
                                style: FormConstants.getTextStyle(),
                                decoration: InputDecoration(
                                  labelText: 'Father\'s Name',
                                  labelStyle: FormConstants.getLabelAndHintStyle(),
                                  // filled: true,
                                  // fillColor: Color(0xffF6F6F6),
                                  border: FormConstants.getEnabledBorder(),
                                  enabledBorder: FormConstants.getEnabledBorder(),
                                  focusedBorder: FormConstants.getFocusedBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: FormConstants.getDropDownBoxDecoration(),
                                child: ListTile(
                                  title: Text(
                                    "Date Of Death:    ${DateFormat('dd-MM-yyyy').format(_selectedDateOfDeath)}",
                                    style: FormConstants.getTextStyle(),
                                  ),
                                  trailing: FormConstants.getCalenderIcon(),
                                  onTap: _pickDateOfDeath,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedPanchayatDeath = null;
                                          deathRegistrationNumberController
                                              .clear();
                                          deathApplicantNameController.clear();
                                          deathApplicantFatherNameController
                                              .clear();
                                          _selectedDateOfDeath = DateTime.now();
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            side: BorderSide(
                                              color: ColorConstants.formLabelTextColor,
                                            ),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Bold',
                                          color: ColorConstants.formLabelTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // Validate the form inputs
                                        if (_deathCertificateFormKey
                                            .currentState!
                                            .validate()) {
                                          // Form is valid, do something here
                                          print('Form is valid!');

                                          Map<String, String> deathBody = {
                                            "panchayat":
                                                _selectedPanchayatDeath!,
                                            "registration_no":
                                                deathRegistrationNumberController
                                                    .text,
                                            "name": deathApplicantNameController
                                                .text,
                                            "date_of_birth":
                                                DateFormat('dd-MM-yyyy').format(
                                                    _selectedDateOfDeath),
                                            "father_name":
                                                deathApplicantFatherNameController
                                                    .text,
                                          };

                                          var response = await BirthAndDeathCertificateAPIService.getDeathCertificate(deathBody);
                                        }
                                      },
                                      child: Text(
                                        'Search',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Bold',
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            ColorConstants.submitGreenColor),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
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
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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

  _pickDateOfBirth() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime(1950).year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: _selectedDateOfBirth,
    );

    if (date != null) {
      setState(() {
        _selectedDateOfBirth = date;
      });
    }
  }

  _pickDateOfDeath() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime(1950).year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: _selectedDateOfDeath,
    );

    if (date != null) {
      setState(() {
        _selectedDateOfDeath = date;
      });
    }
  }
}
