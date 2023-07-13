import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:we_panchayat_dev/screens/auth/signup.dart';
import 'package:we_panchayat_dev/screens/otp/otptimer.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/screens/reset_password/reset_password.dart';
import 'package:we_panchayat_dev/services/api_service.dart';

import '../../constants.dart';

class SignUpOtp extends StatefulWidget {

  final String phone;

  SignUpOtp({super.key, this.phone = ""});

  @override
  SignUpOtpState createState() => new SignUpOtpState();
}

class SignUpOtpState extends State<SignUpOtp> {
  String? _otpSignUpText;

  @override
  Widget build(BuildContext context) {
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
        // resizeToAvoidBottomInset: true,
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
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Text(
                              'OTP Verification',
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff21205b),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Enter the 6 digit code that you received.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins-Light',
                                color: ColorConstants.formLabelTextColor,
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 45.0,
                                  right: 45.0,
                                  top: 30.0,
                                  bottom: 30.0),
                              child: PinCodeTextField(
                                autoFocus: true,
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
                                ),
                                onCompleted: (value) {
                                  // Handle the completed OTP code
                                  _otpSignUpText = value;
                                  print('Entered OTP : $_otpSignUpText');
                                },
                                appContext: context,
                                onChanged: (String value) {},
                              ),
                            ),
                            // OtpTimer(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    "Didn't receive OTP?",
                                    style: TextStyle(
                                        color: ColorConstants.formLabelTextColor,
                                        fontFamily: 'Poppins-Light'// or any other color you want
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        // logic to resend the OTP
                                        APIService.resendOtp();
                                      },
                                      child: Text(
                                        "Resend",
                                        style: TextStyle(
                                            color: ColorConstants.colorHuntCode2,
                                            fontFamily: 'Poppins-Medium'// or any other color you want
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
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
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_otpSignUpText != null && _otpSignUpText?.length == 6) {
                      Map body = {"otp": _otpSignUpText};

                      APIService.verifyOtpResetPassword(body).then((response) {
                        if (response) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('OTP Verified. Enter your details.')));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp(phone: widget.phone,)),
                                (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Incorrect OTP.')));
                        }
                      });
                    }
                    // if (_otpResetPasswordText != null && _otpResetPasswordText?.length == 6) {
                    //   if(_otpResetPasswordText == "111111") {
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //               const SnackBar(
                    //                   content: Text('OTP Verified. Enter new password.')));
                    //           Navigator.pushAndRemoveUntil(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const ResetPassword()),
                    //                 (route) => false,
                    //           );
                    //   }
                    // }

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
      ),
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
