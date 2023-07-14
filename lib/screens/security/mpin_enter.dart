import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/otp/otptimer.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/screens/security/security.dart';
import 'package:we_panchayat_dev/services/api_service.dart';

import '../../services/shared_service.dart';
import 'mpin_confirm.dart';

class EnterMPINScreen extends StatefulWidget {
  const EnterMPINScreen({super.key});

  @override
  EnterMPINScreenState createState() => new EnterMPINScreenState();
}

class EnterMPINScreenState extends State<EnterMPINScreen> {
  TextEditingController _enterMPINController = TextEditingController();

  bool _isMPINMatched = true;


  Future<bool> getMPINState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('mpinEnabled') ?? false;
    return isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: ColorConstants.backgroundClipperColor,
        // ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: ColorConstants.darkBlueThemeColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(
                      Icons.lock_outline,
                      color: Colors.black54,
                      size: 36,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Use MPIN lock',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Poppins-Bold',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2B2730),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          'Use a 4-digit MPIN to protect your wE-Panchayat app',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Light',
                            fontSize: 12,
                            color: Color(0xff2B2730),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 45.0, right: 45.0, top: 30.0, bottom: 30.0),
                          child: PinCodeTextField(
                            controller: _enterMPINController,
                            autoFocus: true,
                            length: 4,
                            // The length of the OTP code
                            obscureText: true,
                            // Whether to obscure1 the entered text
                            animationType: AnimationType.scale,
                            keyboardType: TextInputType.number,
                            // The animation type
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              // borderRadius: BorderRadius.circular(5),
                              fieldHeight: 40,
                              fieldWidth: 40,
                              activeColor: Colors.black,
                              selectedColor: Colors.black,
                              inactiveColor: Colors.grey,
                              activeFillColor: Colors.white,
                            ),
                            onCompleted: (value) async {
                              // Handle the completed OTP code
                                String? mpin = await SharedService.getMPIN();
                                if(_enterMPINController.text == mpin) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                }
                                else {
                                  setState(() {
                                    _isMPINMatched = false;
                                  });
                                }
                            },
                            appContext: context,
                            onChanged: (String value) {},
                          ),
                        ),
                        Visibility(
                          child: Text(
                            "MPIN does not match",
                            style: TextStyle(
                              fontFamily: 'Poppins-Light',
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          visible: !_isMPINMatched,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String? mpin = await SharedService.getMPIN();
                  if(_enterMPINController.text == mpin) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home()),
                    );
                  }
                  else {
                    setState(() {
                      _isMPINMatched = false;
                    });
                  }
                },
                child: Text("Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Bold',
                    )),
                style: AuthConstants.getSubmitButtonStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
