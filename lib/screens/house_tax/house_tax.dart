import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/config.dart';
import 'package:we_panchayat_dev/models/house_tax_response_model.dart';
import 'package:we_panchayat_dev/services/house_tax_api_service.dart';

import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import '../../constants.dart';
import '../dialog_boxes.dart';

class HouseTax extends StatefulWidget {
  HouseTax({Key? key}) : super(key: key);

  @override
  _HouseTaxState createState() => _HouseTaxState();
}

class _HouseTaxState extends State<HouseTax> {
  TextEditingController applicantName = TextEditingController();
  TextEditingController applicantGuardianName = TextEditingController();
  TextEditingController mobile = TextEditingController();

  bool _isAPIcallProcess = false;

  final _formKey = GlobalKey<FormState>();
  Map<String, List<String>> _mappedPanchayatAndRevenueVillages = {
    "Assolda": [
      'ASSOLDA'
          'ODAR'
          'XELVONA'
          'XIC-XELVONA'
    ],
    "Advalpal": [
      'ADWALPALE',
    ],
    "Agarwada,Chopdem": [
      'AGARWADO',
      'CHOPDEM',
    ],
    "Agonda": [
      'AGONDA',
    ],
    "Aldona": [
      'ALDONA',
      'CALVIM',
      'KHORJUVEM',
      'PONOLI',
    ],
    "Alorna": [
      'ALORNA',
    ],
    "Ambaulim": [
      'AMBAULIM',
    ],
    "Ambelim": [
      'AMBELIM',
    ],
    "Amona": [
      'AMONE',
    ],
    "Anjuna": [
      'ANJUNA',
    ],
    "Aquem Baixo": [
      'AQUEM',
    ],
    "Arambol": [
      'ARAMBOL',
    ],
    "Arpora-Nagoa": [
      'ARPORA',
      'NAGOA',
    ],
    " Assagao ": [
      'ASSAGAO',
    ],
    " Assanora ": [
      'ASSNODA',
      'MOITEM',
    ],
    " Assolda ": [
      'ASSOLDA',
      'ODAR',
      'XELVONA',
      'XIC-XELVONA',
    ],
    " Assolna ": [
      'ASSOLNA',
    ],
    " Avedem-Cotombi ": [
      'AVEDEM',
      'CHAIFI',
      'COTOMBI',
    ],
    "Azossim-Mandur": [
      'AZOSSIM',
      'MANDUR',
    ],
    "Balli-Adnem": [
      'ADNEM',
      'BALI',
      'BENDORDEM',
      'CORDEM',
      'TILOI',
    ],
    "Bandora": [
      'BANDORA',
    ],
    " Barcem": [
      'BARCEM',
      'GOCOLDEM',
      'PADI',
      'QUEDEM',
      'QUISCONDA',
    ],
    " Bastora": [
      'BASTORA',
    ],
    " Batim": [
      'GANCIM',
      'BATIM',
    ],
    " Benaulim": [
      'BENAULIM',
      'ADSULIM',
      'CANA',
    ],
    " Betalbatim": [
      'BATALBATIM',
      'GONSUA',
    ],
    "Betora-Nirancal": [
      'BETORA',
      'CODAR',
      'CONXEM',
      'NIRANCAL',
    ],
    "Betqui, Candola": [
      'BETQUI',
      'CANDOLA',
    ],
    "Bhati": [
      'BATI',
      'CUMBARI',
      'DONGOR',
      'NAIQUINIM',
      'POTREM',
      'SIGONEM',
      'TODAU',
      'VILIENA',
    ],
    "Bhoma-Adcolna": [
      'ADCOLNA',
      'BHOMA',
    ],
    "Birondem": [
      'ADVOI',
      'ANSOLEM',
      'BIRONDEM',
      'PADELI',
      'SANVORCEM',
      'VANTEM',
    ],
    "Borim": [
      'BORIM',
    ],
    "Calangute": [
      'CALANGUTE',
    ],
    "Camurlim": [
      'KAMURLI',
    ],
    "Camorlim": [
      'CAMURLIM',
    ],
    "Candolim": [
      'CANDOLIM',
      'MARRA',
    ],
    "Carambolim": [
      'CARAMBOLIM',
    ],
    "Carmona": [
      'CARMONA',
    ],
    "Casnem, Amberem,Poroscodem": [
      'POROSCODEM',
      'AMBEREM',
      'CASNEM',
    ],
    "Caurem": [
      'CAVOREM',
      'CAZUR',
      'CORLA',
      'MAINA',
      'MANGAL',
      'PIRLA',
      'SULCORNA'
    ],
    "Cavelossim": [
      'CAVELOSSIM',
    ],
    "Chandel Hassapur": [
      'CHANDEL',
    ],
    "Chandor-Cavorim": [
      'CAVORIM',
      'CHANDOR',
    ],
    "Chicalim": [
      'DABOLIM',
      'CHICALIM',
      'SAOJACINTOISLAND',
      'SAOJORGEISLAND',
    ],
    "Chicolna-Bogmalo": [
      'CHICOLNA',
    ],
    "Chimbel": [
      'CHIMBEL',
    ],
    "Chinchinim- Deussua": [
      'CHINCHINIM',
      'DEUSSUA',
    ],
    "Chodan-Madel": [
      'AMBARIM',
      'CHORAO',
      'CARAIM',
    ],
    "Cola": [
      'COLA',
    ],
    "Colem": [
      'CARANZOL',
      'COLEM',
      'SIGAO',
      'SONAULIM',
    ],
    "Colva": ['COLVA', 'GANDAULIM', 'SERNABATIM', 'VANELI'],
    "Colvale": [
      'COLVALE',
    ],
    "Corgao": [
      'CORGAO',
    ],
    "Corlim": [
      'CORLIM',
    ],
    "Cortalim": [
      'CORTALIM',
    ],
    "Cotigao": [
      'COTIGAO',
    ],
    "Cotorem": [
      'COLA',
      'MALPONA',
      'GOVANEM',
      'CODQUI',
      'SIRANGULI',
      'ASSODEM',
      'AMBELI',
      'XELOPO-CURDO',
      'VELGUEM',
      'SIRSODEM',
      'COTOREM',
    ],
    "Cudnem": [
      'CUDNEM',
    ],
    "Cansaulim-Arossim-Cuelim": [
      'CANSAULIM',
      'AROSSIM',
      'CUELIM',
    ],
    "Cumbharjua": [
      'CUMBHARJUA',
      'GANDAULIM',
    ],
    "Curca,Bambolim,Talaulim": [
      'CURCA',
      'GOALIM-MOULA',
      'TALAULIM',
      'BAMBOLIM',
    ],
    "Curdi": [
      'CURDI',
      'CURPEM',
      'PORTEM',
    ],
    "Curti-Khandepar": [
      'CURTI',
      'CANDEPAR',
    ],
    "Curtorim": [
      'CURTORIM',
    ],
    "Davorlim,Dicarpale": [
      'DICARPALE',
    ],
    "Dharbandora": [
      'DHARBANDORA',
      'PILIEM',
    ],
    "Dhargal": [
      'DARGALIM',
    ],
    "Dongurli": [
      'IVREM-BUZRUCO',
      'SURLA',
      'DONGURLI',
      'RIVEM',
      'IVREM-CURDO',
      'PALE',
      'CHORAUNDEM',
      'GOLAULI',
      'NANELI'
    ],
    "Dharmapur": [
      'DHARMAPUR',
    ],
    "Durbhat": [
      'DURBHAT',
    ],
    "Fatorpa-Quitol": [
      'FATORPA',
    ],
    "Gaondongri": [
      'GAODONGREM',
    ],
    "Goltim-Navelim": [
      'GOTLIM',
      'NAVELIM',
    ],
    "Guirdolim": [
      'GUIRDOLIM',
    ],
    "Guirim": [
      'GUIRIM',
    ],
    "Guleli": ['CONQUIREM', 'DAMOCEM', 'GULELI', 'MELAULI'],
    "Honda": [
      'BUIMPAL',
      'ONDA',
      'SALELI',
      'SONUS-VONVOLIEM',
    ],
    "Ibrampur": [
      'IBRAMPUR',
    ],
    "Kalay(Kalem)": [
      'BOMA',
      'CALEM',
      'COSTI',
      'DONGURLIM',
      'DUDAL',
      'MAULINGUEM',
      'OXEL'
    ],
    "Karapur-Sarvan": [
      'KARAPUR',
      'SARVONA',
    ],
    "Kasarvanem": [
      'CANSARVORNEM',
    ],
    "Querim-Tiracol": [
      'QUERIM',
      'TIRACOL',
    ],
    "Kerim": [
      'ANJUNEM',
      'GONTELI',
      'GULULEM',
      'PONSULI',
      'QUELAUDEM',
      'QUERIM',
      'RAVONA',
      'SIROLI',
    ],
    "Kirlapal-Dabhal": [
      'BANDOLI',
      'CAMARCOND',
      'CODLI',
      'CORMONEM',
      'MOISSAL',
    ],
    "Kundaim": [
      'CUNDAIM',
    ],
    "Latambarcem": [
      'LATAMBARCEM',
    ],
    "Loliem-Polem": [
      'ANGEDIVA',
      'LOLIEM',
    ],
    "Loutulim": [
      'LOUTOLIM',
    ],
    "Macasana": [
      'MACAZANA',
    ],
    "Majorda-Utorda-Calata": [
      'CALATA',
      'MAJORDA',
      'UTORDA',
    ],
    "Mandrem": [
      'MANDREM',
    ],
    "Marcaim": [
      'MARCAIM',
    ],
    "Maulinguem": [
      'CURCHIREM',
      'MAULINGUEM-NORTH',
      'MAULINGUEM-SOUTH',
      'ONA',
    ],
    "Mauxi": [
      'COMPORDEM',
      'DABEM',
      'MAUXI',
      'NAGUEM',
      'ZORMEN',
    ],
    "Mayem": [
      'ATURLI',
      'MAEM',
      'VAINGUINIM',
    ],
    "Mencurem": [
      'DUMACEM',
      'MENCUREM',
    ],
    "Merces": [
      'MORAMBI-O-GRANDE',
      'MORAMBI-O-PEQUENO',
      'MURDA',
      'RENOVADI',
    ],
    "Moira": [
      'MOIRA',
    ],
    "Molcornem": [
      'MOLCARNEM',
      'MOLCOPONA',
      'NAGVEM',
      'UNDORNA',
      'ZANODEM',
    ],
    "Mollem": [
      'MOLLEM',
      'SANGOD',
    ],
    "Morjim": [
      'MORGIM',
    ],
    "Morlem": [
      'MORLEM',
    ],
    "Morpirla": [
      'MORPIRLA',
    ],
    "Mulgao": [
      'MULGAO',
    ],
    "Nachinola": [
      'NACHINOLA',
    ],
    "Nadora": [
      'NADORA',
    ],
    "Nagargao": [
      'AMBEDEM',
      'DAVEM',
      'EDOREM',
      'NANOREM',
      'XELOPO-BUZRUCO',
      'CARAMBOLIM-BRAMA',
      'NAGARGAO',
      'USTEM',
      'MALOLI',
      'ZARANI',
      'DERODEM',
      'SATREM',
      'VAINGUINIM',
      'SIGONEM',
      'SATOREM',
      'CODAL',
      'BOMBEDEM',
    ],
    "Nagoa": [
      'NAGOA',
    ],
    "Naqueri-Betul": [
      'NAQUERIM',
      'QUITOL',
    ],
    "Naroa": [
      'NAROA',
    ],
    "Navelim,Bicholim": [
      'NAVELIM',
    ],
    "Navelim Salcete": [
      'NAVELIM',
    ],
    "Nerul": [
      'NERUL',
    ],
    "Neturlim": [
      'NETURLIM',
      'NUNDEM',
      'VERLEM',
      'VICHUNDREM',
    ],
    "Neura": [
      'NEURA-O-GRANDE',
      'NEURA-O-PEQUENO',
    ],
    "Nuvem": [
      'NUVEM',
    ],
    "Orlim": [
      'ORLIM',
    ],
    "Oxel": [
      'OXEL',
    ],
    "Ozarim": [
      'OZORIM',
    ],
    "Pale,COtombi": [
      'COTOMBI',
      'PALE',
    ],
    "Paliem": [
      'PALIEM',
    ],
    "Panchawadi": [
      'PONCHAVADI',
    ],
    "Parcem": [
      'PARCEM',
    ],
    "Paroda": [
      'MULEM',
      'PARODA',
    ],
    "Parra": [
      'PARRA',
    ],
    "Penha-De-Franca": [
      'PENHA DE FRANCE',
    ],
    "Pilerne": [
      'PILERNE',
    ],
    "Piligao": [
      'PILIGAO',
    ],
    "Pirna": [
      'PIRNA',
    ],
    "Pissurlem": [
      'CODIEM',
      'CUMARCONDA',
      'PISSURLEM',
      'PONOCEM',
      'VAGURIEM',
    ],
    "Poinguinim": [
      'POINGUINIM',
    ],
    "Pomburpa-Olaulim": [
      'OLAVALI',
      'POMBURPA',
    ],
    "Poriem": [
      'PODOCEM',
      'PORIEM',
    ],
    "Quela": [
      'QUELA',
    ],
    "Querim": [
      'QUERIM',
    ],
    "Rachol": [
      'RACHOL',
    ],
    "Raia ": [
      'RAIA',
    ],
    "Revora ": [
      'REVORA',
    ],
    "Rivona ": [
      'COLOMBA',
      'RIVONA',
    ],
    "Rumdamol-Davorlim ": [
      'DAVORLIM',
    ],
    "Salem ": [
      'SAL',
    ],
    "Saligao ": [
      'SALIGAO',
    ],
    "Salvador-Do-Mundo ": [
      'SALVADOR DO MUNDO',
    ],
    "Sancoale ": [
      'SANCOALE',
    ],
    "Sancordem ": [
      'AGLOTE',
      'SANCORDEM',
      'SURLA',
    ],
    "Sangolda ": [
      'SANGOLDA',
    ],
    "Sanvordem(Sattari) ": [
      'CARAMBOLIM-BUZRUCO',
      'CARANZOL',
      'CODVOL',
      'CUDCEM',
      'PENDRAL',
      'SANVORDEM',
      'SONAL',
    ],
    "Sanvordem(Sanguem) ": [
      'ANTOREM',
      'COMPROI',
      'CORANGUINIM',
      'RUMBREM',
      'SANTONA',
      'SANVORDEM',
    ],
    "Sao Lourence(Agassaim) ": [
      'MERCURIM',
    ],
    "Sao Matias ": [
      'MALAR',
      'NAROA',
      'CAPAO',
    ],
    "Sarzora ": [
      'SARZORA',
    ],
    "Se-Old-Goa ": [
      'ELLA',
      'BAINGUINIM',
      'PANELIM',
    ],
    "Seraulim ": [
      'DUNCOLIM',
      'SERAULIM',
    ],
    "Shiroda ": [
      'SIRODA',
    ],
    "Shristhal ": [
      'CANACONA',
    ],
    "Siolim-Marna ": [
      'MARNA',
    ],
    "Siolim-Sodiem ": [
      'SIOLIM',
    ],
    "Siridao-Palem ": [
      'SIRIDAO',
    ],
    "Sirigao ": [
      'SIRIGAO',
    ],
    "Sirsasim ": [
      'SIRSAI',
    ],
    "Socorro ": [
      'SOCORRO',
    ],
    "St. Andre ": [
      'GOA-VELHA',
    ],
    " St. Cruz ": [
      'CUJIRA ',
      'CALAPOR ',
    ],
    " St. Estevam ": [
      'JUA ',
    ],
    "St. Jose-De-Areal": [
      'SAO JOSE DE AREAL ',
    ],
    "Surla": [
      'SURLA ',
    ],
    "Talaulim": [
      'TALAULIM ',
      'VADI',
    ],
    "Taleigao": [
      'Taleigao',
    ],
    "Tamboxem,Mopa,Uguem": [
      'TAMBOXEM ',
      'UGUEM',
      'MOPA',
    ],
    "Telaulim": [
      'TALAULIM ',
    ],
    "Tivim": [
      'TIVIM ',
    ],
    "Tivrem-Orgao": [
      'ORGAO ',
      'TIVREM',
    ],
    "Torxem": [
      'Torxem ',
    ],
    "Tuem": [
      'TUEM ',
    ],
    "Ucassaim,Paliem-Punola": [
      'PALIEM ',
      'PUNOLA',
      'UCCASSAIM',
    ],
    "Uguem": [
      'COTARLI',
      'MUGULI',
      'PATIEM',
      'SALAULI',
      'UGUEM',
      'XELPEM',
    ],
    "Usgao-Ganjem": [
      'GANGEM',
      'USGAO',
    ],
    "Varca": [
      'VARCA',
    ],
    "Varkhand Nagzar": [
      'VARCONDA',
    ],
    "Velguem": [
      'VELGUEM',
    ],
    "VELIM": [
      'VELIM',
    ],
    "Veling,Priol,Cuncoliem": [
      'VELING',
      'PRIOL',
      'VELIM',
    ],
    "Velsao-Pale": [
      'ISSORCIM',
      'PALE',
      'VELSAO',
    ],
    "Reis Magos": [
      'REIS MAGOS',
    ],
    "Verem,Vaghurme": [
      'SAVOI-VEREM',
      'VAGURBEM',
    ],
    "Verla Canca": [
      'CANKA',
      'VERLA',
    ],
    "Verna": [
      'VERNA',
    ],
    "Virnoda": [
      'VIRNORA',
    ],
    "Volvoi": [
      'VOLVOI',
    ],
    "Xeldem": [
      'SIRVOI',
      'XELDEM',
    ],
    "Harvalem": [
      'ARVALEM',
    ],
    "Quelossim": [
      'QUELOSSIM',
    ],
  };

  String? _selectedPanchayat;
  String? _selectedRevenueVillage;

  List<DropdownMenuItem<String>> villageMenuItems = [];

  TextEditingController _houseNumberController = TextEditingController();
  TextEditingController _nameOfPayeeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  HouseTaxResponseModel? _model;
  bool _isResponse = false;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialiseNamePhoneAddress();
    _houseNumberController.addListener(() {
      if (_houseNumberController.text.isEmpty) {
        _houseNumberController.clear();
      }
    });
    _nameOfPayeeController.addListener(() {
      if (_nameOfPayeeController.text.isEmpty) {
        _nameOfPayeeController.clear();
      }
    });
    _emailController.addListener(() {
      if (_emailController.text.isEmpty) {
        _emailController.clear();
      }
    });
    _mobileNumberController.addListener(() {
      if (_mobileNumberController.text.isEmpty) {
        _mobileNumberController.clear();
      }
    });
  }

  Future<void> initialiseNamePhoneAddress() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    setState(() {
      _nameOfPayeeController =
          TextEditingController(text: loginResponseModel?.fullname);
      _emailController = TextEditingController(text: loginResponseModel?.email);
      _mobileNumberController =
          TextEditingController(text: loginResponseModel?.phone);
    });
  }

  void secondselected(_value) {
    setState(() {
      _selectedRevenueVillage = _value;
      debugPrint("Selected Two Taluka = $_selectedPanchayat");
      debugPrint("Selected Two village = $_selectedRevenueVillage");
    });
  }

  bool disabledVillageMenuItem = true;

  void selected(_value) {
    villageMenuItems = [];
    populateRevenueVillageMenuItem(_mappedPanchayatAndRevenueVillages[_value]);
    setState(() {
      _selectedPanchayat = _value;

      _selectedRevenueVillage = _mappedPanchayatAndRevenueVillages[_value]![0];

      debugPrint("Selected One Panchayat = $_selectedPanchayat");
      debugPrint("Selected One village = $_selectedRevenueVillage");

      disabledVillageMenuItem = false;
    });
  }

  void populateRevenueVillageMenuItem(List<String>? villages) {
    for (String village in villages!) {
      villageMenuItems.add(
        DropdownMenuItem<String>(
          child: Center(
            child: Text(
              village,
              style: FormConstants.getDropDownTextStyle(),
            ),
          ),
          value: village,
        ),
      );
    }
  }

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showCancelConfirmationDialog(context, false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xffCDF0EA),
          foregroundColor: Color(0xff088395),
          title: Text(
            'Pay Your House Tax',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 18,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Color(0xffCDF0EA),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView(
                controller: _scrollController,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'House Tax',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      color: ColorConstants.darkBlueThemeColor,
                      fontSize: 20,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration:
                                    FormConstants.getDropDownBoxDecoration(),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 200,
                                  decoration: const InputDecoration(
                                    border: InputBorder
                                        .none, // Remove the bottom border
                                  ),
                                  isExpanded: true,
                                  icon: FormConstants.getDropDownIcon(),
                                  value: _selectedPanchayat,
                                  items: _mappedPanchayatAndRevenueVillages.keys
                                      .map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: FormConstants.getDropDownTextStyle(),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (_value) => selected(_value),
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
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration:
                                    FormConstants.getDropDownBoxDecoration(),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 200,
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder
                                        .none, // Remove the bottom border
                                  ),
                                  icon: FormConstants.getDropDownIcon(),
                                  value: _selectedRevenueVillage,
                                  items: villageMenuItems,
                                  onChanged: disabledVillageMenuItem
                                      ? null
                                      : (_value) => secondselected(_value),
                                  disabledHint: Text(
                                    "Revenue Village",
                                    style: FormConstants.getDropDownDisabledStyle(),
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
                        const SizedBox(height: 16),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            } else if (!RegExp(r"^\d{1,}(\/[A-Za-z0-9]+)*$")
                                .hasMatch(value)) {
                              return 'Invalid House No.';
                            }
                            return null;
                          },
                          controller: _houseNumberController,
                          style: FormConstants.getTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'House Number',
                            labelStyle: FormConstants.getLabelAndHintStyle(),
                            hintText: 'Eg. 12/345/',
                            hintStyle: FormConstants.getLabelAndHintStyle(),
                            // filled: true,
                            // fillColor: Color(0xffF6F6F6),
                            border: FormConstants.getEnabledBorder(),
                            enabledBorder: FormConstants.getEnabledBorder(),
                            focusedBorder: FormConstants.getFocusedBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Required";
                            }
                            return null;
                          },
                          controller: _nameOfPayeeController,
                          style: FormConstants.getTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Name of Payee',
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
                            if (value!.isEmpty) {
                              return "Required";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Invalid email";
                            }
                          },
                          controller: _emailController,
                          style: FormConstants.getTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Email',
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
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          controller: _mobileNumberController,
                          style: FormConstants.getTextStyle(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            } else if (!RegExp(r"^[789]\d{9}$").hasMatch(value)) {
                              return "Invalid mobile no.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: FormConstants.getLabelAndHintStyle(),
                            border: FormConstants.getEnabledBorder(),
                            enabledBorder: FormConstants.getEnabledBorder(),
                            focusedBorder: FormConstants.getFocusedBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedPanchayat = null;
                                    _selectedRevenueVillage = null;
                                    disabledVillageMenuItem = true;

                                    _houseNumberController.clear();
                                    _nameOfPayeeController.clear();
                                    _emailController.clear();
                                    _mobileNumberController.clear();

                                    _isResponse = false;
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
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                                  if (_formKey.currentState!.validate()) {
                                    // Form is valid, do something here
                                    print('Form is valid!');

                                    Map<String, String> body = {
                                      "panchayat": _selectedPanchayat!,
                                      "revenue_village": _selectedRevenueVillage!,
                                      "house_no": _houseNumberController.text,
                                      // "applicants_name": applicantNameController.text,
                                      // "applicants_address": applicantAddressController.text,
                                      // "phone": applicantPhoneNoController.text,
                                      // "email": applicantEmailController.text,
                                    };

                                    setState(() {
                                      _isAPIcallProcess = true;
                                    });

                                    var res =
                                        await HouseTaxAPIService.getTaxDetails(
                                            body);

                                    setState(() {
                                      _isAPIcallProcess = false;
                                    });

                                    if(res != null) {
                                      if (res.statusCode == 200) {
                                        setState(() {
                                          _model = houseTaxResponseJson(res.body);
                                          _isResponse = true;
                                        });

                                        // Scroll the form upwards after receiving the response
                                        _scrollController.animateTo(
                                          540,
                                          duration: Duration(milliseconds: 1000),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        if (_isResponse) {
                                          setState(() {
                                            _isResponse = false;
                                            _model = null;
                                          });
                                        }
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Record does not exist.'),
                                          ),
                                        );
                                      }
                                    } else {
                                      DialogBoxes.showServerDownDialogBox(context);
                                    }


                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      ColorConstants.darkBlueThemeColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.only(top: 15.0, bottom: 15.0),
                                  ),
                                ),
                                child: const Text(
                                  'Search',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  if (_isResponse) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "For Financial Year\n April 2023 to March 2024",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              color: Color(0xff21205b),
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "House Number : ",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Color(0xff7b7f9e),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${_model?.data?.houseNo!}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Name of Owner : ",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Color(0xff7b7f9e),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${_model?.data?.ownerName!}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Address : ",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Color(0xff7b7f9e),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${_model?.data?.address!}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Amount Payable",
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              color: Color(0xff7b7f9e),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Rs. ${_model?.data?.amountPayable!}",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              color: Color(0xff6CC51D),
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Status : ",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Color(0xff7b7f9e),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (_model?.data?.paid! == true) ...[
                                Expanded(
                                  child: Text(
                                    "Paid",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      color: ColorConstants.submitGreenColor,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ] else ...[
                                Expanded(
                                  child: Text(
                                    "Unpaid",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: ColorConstants.formBorderColor, width: 2),
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.house_outlined,
                                      color: Color(0xff7b7f9e),
                                    ),
                                    Text(
                                      "House tax",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Color(0xff7b7f9e),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Table(
                                  // border: TableBorder.all(),
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Demand Amount',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Collection Amount',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Notice Fee',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseNoticeFeeDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseNoticeFeeCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Warrant Fee',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseWarrantFeeDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseWarrantFeeCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Arrears',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseArrearsDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseArrearsCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Penalty',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.housePenaltyDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.housePenaltyCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Current',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseCurrentDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.houseCurrentCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: ColorConstants.formBorderColor, width: 2),
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Color(0xff7b7f9e),
                                    ),
                                    Text(
                                      "Garbage tax",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Color(0xff7b7f9e),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Table(
                                  // border: TableBorder.all(),
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Demand Amount',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Collection Amount',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Arrears',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.garbageArrearsDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.garbageArrearsCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Current',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.garbageCurrentDa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.garbageArrearsCa!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: ColorConstants.formBorderColor, width: 2),
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: Color(0xff7b7f9e),
                                    ),
                                    Text(
                                      "Total tax",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Color(0xff7b7f9e),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Table(
                                  // border: TableBorder.all(),
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'House Tax',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.totalHouseTax!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            child: Text(
                                              'Garbage Tax',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_model?.data?.totalGarbageTax!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            // color: Colors.grey[300],
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 1.0,
                                                    color: Colors.black45),
                                              ),
                                            ),
                                            child: Text(
                                              'Amount Payable',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Bold',
                                                color: Color(0xff21205b),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 1.0,
                                                    color: Colors.black45),
                                              ),
                                            ),
                                            child: Text(
                                              '${_model?.data?.amountPayable!}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  // color: Colors.grey,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.formBorderColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: ColorConstants.darkBlueThemeColor,
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "In case of any discrepency in data, kindly contact Village Panchayat Office.",
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 12,
                                            color:
                                                ColorConstants.darkBlueThemeColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_model?.data?.paid! == false) ...[
                            const SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      ColorConstants.submitGreenColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.only(top: 15.0, bottom: 15.0),
                                  ),
                                ),
                                child: const Text(
                                  'Proceed to payment',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            if (_isAPIcallProcess)
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
              ),
            if (_isAPIcallProcess)
              Center(
                child: CircularProgressIndicator(color: Colors.white,
                  strokeWidth: 6,),
              ),
          ],
        ),
      ),
    );
  }
}
