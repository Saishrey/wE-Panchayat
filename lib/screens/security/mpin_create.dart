import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/otp/otptimer.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/services/api_service.dart';

import 'mpin_confirm.dart';

class CreateMPINScreen extends StatefulWidget {
  const CreateMPINScreen({super.key});

  @override
  CreateMPINScreenState createState() => new CreateMPINScreenState();
}

class CreateMPINScreenState extends State<CreateMPINScreen> {
  TextEditingController _createMPINController = TextEditingController();

  bool _isMPINEntered = true;

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
                    child: Icon(
                      Icons.lock_outline,
                      color: Colors.black54,
                      size: 36,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Create MPIN',
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
                              left: 45.0, right: 45.0, top: 30.0, bottom: 30.0),
                          child: PinCodeTextField(
                            controller: _createMPINController,
                            autoFocus: true,
                            length: 4,
                            // The length of the OTP code
                            // obscureText: true,
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
                            onCompleted: (value) {
                              // Handle the completed OTP code
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmMPINScreen(
                                        mpin: _createMPINController.text)),
                              );
                            },
                            appContext: context,
                            onChanged: (String value) {},
                          ),
                        ),
                        Visibility(
                          child: Text(
                            "Enter MPIN",
                            style: TextStyle(
                              fontFamily: 'Poppins-Light',
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          visible: !_isMPINEntered,
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
                  if (_createMPINController.text.length == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmMPINScreen(
                              mpin: _createMPINController.text)),
                    );
                  } else {
                    setState(() {
                      _isMPINEntered = false;
                    });
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
