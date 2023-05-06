import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class HouseTax extends StatefulWidget {
  HouseTax({Key? key}) : super(key: key);

  @override
  _HouseTaxState createState() => _HouseTaxState();
}

class _HouseTaxState extends State<HouseTax> {
  TextEditingController applicantName = TextEditingController();
  TextEditingController applicantGuardianName = TextEditingController();
  TextEditingController mobile = TextEditingController();

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
  String? _selectedTaluka;
  String? _selectedVillage;

  List<DropdownMenuItem<String>> villageMenuItems = [];

  void secondselected(_value) {
    setState(() {
      _selectedVillage = _value;
      debugPrint("Selected Two Taluka = $_selectedTaluka");
      debugPrint("Selected Two village = $_selectedVillage");
    });
  }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(' Pay Your House Tax'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
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
                      child: DropdownButton(
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
                          "Select Taluka",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins-Bold',
                          ),
                        ),
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
                      child: DropdownButton(
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
                          "Select Village",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins-Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return " Required   ";
                        }
                        return null;
                      },
                      controller: applicantName,
                      style: TextStyle(
                        color: Colors.black54, //Name
                        fontFamily: 'Poppins-Bold',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Name of Payee *',
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
                  } else if (!RegExp(
                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Invalid email";
                  }
                  // _email = value;
                  // print("Email : $_email");
                  // return null;
                },
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
              const SizedBox(height: 16,),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a house number.';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins-Bold',
                ),
                decoration: InputDecoration(
                  labelText: 'House Number',
                  hintText: 'Enter house number',
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
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else if (!RegExp(r"^[789]\d{9}$").hasMatch(value)) {
                    return "Invalid mobile no.";
                  }   return null;
                },
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Validate the form inputs
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, do something here
                    print('Form is valid!');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
