import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/otp/otptimer.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/services/auth_api_service.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  OtpState createState() => new OtpState();
}

class OtpState extends State<Otp> {

  TextEditingController _otpController = TextEditingController();

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
                              'Enter the OTP sent on your Mobile number',
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
                                onCompleted: (value) {
                                  // Handle the completed OTP code
                                  if (_otpController.text.isNotEmpty && _otpController.text.length == 6) {
                                    Map body = {"otp": _otpController.text};

                                    APIService.verifyOtp(body).then((response) {
                                      if (response) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Logged in successfully.')));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const Home()),
                                              (route) => false,
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Incorrect OTP.')));
                                      }
                                    });
                                  }
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
                    if (_otpController.text.isNotEmpty && _otpController.text.length == 6) {
                      Map body = {"otp": _otpController.text};

                      APIService.verifyOtp(body).then((response) {
                        if (response) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Logged in successfully.')));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Incorrect OTP.')));
                        }
                      });
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
      ),
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
