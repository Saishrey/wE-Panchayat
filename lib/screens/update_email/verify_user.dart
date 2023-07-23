import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/screens/security/mpin_create.dart';
import 'package:we_panchayat_dev/screens/security/mpin_disable.dart';
import 'package:we_panchayat_dev/screens/update_email/update_email.dart';
import 'package:we_panchayat_dev/services/update_email_api_service.dart';

import '../../constants.dart';
import '../../services/auth_api_service.dart';

class VerifyUserUpdateEmail extends StatefulWidget {
  @override
  _VerifyUserUpdateEmailState createState() => _VerifyUserUpdateEmailState();
}

class _VerifyUserUpdateEmailState extends State<VerifyUserUpdateEmail> {

  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: ColorConstants.backgroundClipperColor,
        // ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: ColorConstants.lightBlackColor,

        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
            const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
            child: const Text(
              'Verify User',
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontSize: 26,
                color: Color(0xff2B2730),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: const Text(
              'Enter the OTP sent to your Mobile number for verification',
              style: TextStyle(
                fontFamily: 'Poppins-Light',
                fontSize: 15,
                color: Color(0xff2B2730),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 45.0,
                      right: 45.0,
                      top: 30.0,
                      bottom: 30.0),
                  child: PinCodeTextField(
                    autoFocus: true,
                    controller: _otpController,
                    length: 6,
                    // The length of the OTP code
                    obscureText: true,
                    // Whether to obscure the entered text
                    animationType: AnimationType.scale,
                    keyboardType: TextInputType.number,
                    // The animation type
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.black54,
                      selectedColor: ColorConstants.lightBlueThemeColor,
                    ),
                    onCompleted: (value) async {
                      // Handle the completed OTP code
                      if (_otpController.text.isNotEmpty && _otpController.text.length == 6) {
                        Map<String, String> body = {"otp": _otpController.text};

                        bool response = await UpdateEmailAPIService.verifyOtpUpdateEmail(body);

                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('OTP verified')));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateEmailPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Incorrect OTP.')));
                          }
                      }
                    },
                    appContext: context,
                    onChanged: (String value) {},
                  ),
                ),
                const SizedBox(height: 60,),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_otpController.text.isNotEmpty && _otpController.text.length == 6) {
                    Map<String, String> body = {"otp": _otpController.text};

                    bool response = await UpdateEmailAPIService.verifyOtpUpdateEmail(body);

                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('OTP verified')));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateEmailPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Incorrect OTP.')));
                    }
                  }
                },
                child: Text("Verify",
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
}
