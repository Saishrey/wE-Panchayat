import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/otp/otptimer.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/screens/security/security.dart';
import 'package:we_panchayat_dev/services/auth_api_service.dart';

import '../../services/shared_service.dart';
import 'mpin_confirm.dart';

class DisableMPINScreen extends StatefulWidget {
  const DisableMPINScreen({super.key});

  @override
  DisableMPINScreenState createState() => new DisableMPINScreenState();
}

class DisableMPINScreenState extends State<DisableMPINScreen> {
  TextEditingController _disableMPINController = TextEditingController();

  bool _isMPINMatched = true;

  bool _showSuccess = false;

  Future<void> setAppLockStateFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appLockEnabled', false);
  }

  Future<bool> getMPINState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('mpinEnabled') ?? false;
    return isEnabled;
  }

  Future<void> setMPINStateFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mpinEnabled', false);
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
        foregroundColor: ColorConstants.lightBlackColor,
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
                      'Disable app lock',
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
                          'Enter your MPIN to disable app lock',
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
                            controller: _disableMPINController,
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
                              bool isMPINEnabled = await getMPINState();
                              if (isMPINEnabled) {
                                String? mpin = await SharedService.getMPIN();
                                if (_disableMPINController.text == mpin) {
                                  setState(() {
                                    _showSuccess = true;
                                    _isMPINMatched = true;
                                  });
                                  await Future.delayed(
                                      Duration(milliseconds: 500));
                                  await SharedService.deleteMPIN();
                                  setAppLockStateFalse();
                                  setMPINStateFalse();
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecurityPage()),
                                  );
                                } else {
                                  setState(() {
                                    _isMPINMatched = false;
                                  });
                                }
                              }
                            },
                            appContext: context,
                            onChanged: (String value) {},
                          ),
                        ),
                        Visibility(
                          child: Text(
                            "Incorrect MPIN",
                            style: TextStyle(
                              fontFamily: 'Poppins-Light',
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          visible: !_isMPINMatched,
                        ),
                        Visibility(
                          child: Column(
                            children: [
                              Icon(
                                Icons.verified_outlined,
                                color: ColorConstants.submitGreenColor,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "MPIN verified ",
                                style: TextStyle(
                                  fontFamily: 'Poppins-Light',
                                  color: ColorConstants.submitGreenColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                                child: LinearProgressIndicator(),
                              ),
                            ],
                          ),
                          visible: _showSuccess,
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
                  bool isMPINEnabled = await getMPINState();
                  if (isMPINEnabled) {
                    String? mpin = await SharedService.getMPIN();
                    if (_disableMPINController.text == mpin) {
                      setState(() {
                        _showSuccess = true;
                        _isMPINMatched = true;
                      });
                      await Future.delayed(Duration(milliseconds: 500));
                      await SharedService.deleteMPIN();
                      setAppLockStateFalse();
                      setMPINStateFalse();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecurityPage()),
                      );
                    } else {
                      setState(() {
                        _isMPINMatched = false;
                      });
                    }
                  }
                },
                child: Text("Continue",
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
        ],
      ),
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
