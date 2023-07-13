import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/otp/otptimer.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/screens/security/security.dart';
import 'package:we_panchayat_dev/services/api_service.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';

class ConfirmMPINScreen extends StatefulWidget {
  final String? mpin;

  const ConfirmMPINScreen(
      {Key? key, required this.mpin})
      : super(key: key);

  @override
  ConfirmMPINScreenState createState() => ConfirmMPINScreenState();
}

class ConfirmMPINScreenState extends State<ConfirmMPINScreen> {

  TextEditingController _confirmMPINController = TextEditingController();

  bool _isMPINMatched = true;


  Future<void> setAppLockState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appLockEnabled', true);
  }


  Future<void> setMPINState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mpinEnabled', true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorConstants.backgroundClipperColor,
        ),
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
                    child: Icon(Icons.lock_outline, color: Colors.black54, size: 36,),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Confirm MPIN',
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
                          'This MPIN will be requested every time the wE-Panchayat app is opened',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Light',
                            fontSize: 12,
                            color: Color(0xff2B2730),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 45.0,
                              right: 45.0,
                              top: 30.0,
                              bottom: 30.0),
                          child: PinCodeTextField(
                            autoFocus: true,
                            controller: _confirmMPINController,
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
                              if(widget.mpin == _confirmMPINController.text) {
                                setAppLockState();
                                setMPINState();
                                await SharedService.setMPIN(_confirmMPINController.text);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecurityPage()),
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
                onPressed: () {
                  if (_confirmMPINController.text.length == 4 && widget.mpin == _confirmMPINController.text) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ConfirmMPINScreen(
                    //           mpin: _confirmMPINController.text)),
                    // );
                  } else {
                    setState(() {
                      _isMPINMatched = false;
                    });
                  }
                },
                child: Text("Confirm Pin",
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
