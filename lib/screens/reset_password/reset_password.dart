import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/models/login_request_model.dart';

import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/services/auth_api_service.dart';

import 'package:we_panchayat_dev/screens/auth/signup.dart';

import 'package:we_panchayat_dev/screens/auth/login.dart';

import 'package:we_panchayat_dev/screens/otp/otp.dart';

import '../../constants.dart';
import '../../services/shared_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isAPIcallProcess = false;

  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  final _formKey = GlobalKey<FormState>();

  String _password = "";

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;

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
        resizeToAvoidBottomInset: true,
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
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff21205b),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Set a new password for your account so that you can login and access all features.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins-Light',
                          color: ColorConstants.formLabelTextColor,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else if (!isPasswordValid(value)) {
                                      return "Password must have:\n"
                                          "At least 8 characters long.\n"
                                          "At least one uppercase letter.\n"
                                          "At least one lowercase letter.\n"
                                          "At least one number.\n"
                                          "At least one special character.";
                                    }
                                    _password = value;
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  obscureText: _obscureTextNew,
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Color(0xffF6F6F6),
                                    labelText: 'New Password',
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureTextNew = !_obscureTextNew;
                                        });
                                      },
                                      child: Icon(
                                        _obscureTextNew
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    suffixIconColor:
                                        ColorConstants.formLabelTextColor,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else if (!isPasswordValid(value)) {
                                      return "Password must have:\n"
                                          "At least 8 characters long.\n"
                                          "At least one uppercase letter.\n"
                                          "At least one lowercase letter.\n"
                                          "At least one number.\n"
                                          "At least one special character.";
                                    } else if (value != _password) {
                                      return "Passwords do not match.";
                                    }
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  obscureText: _obscureTextConfirm,
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Color(0xffF6F6F6),
                                    labelText: 'Confirm Password',
                                    labelStyle:
                                    AuthConstants.getLabelAndHintStyle(),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureTextConfirm = !_obscureTextConfirm;
                                        });
                                      },
                                      child: Icon(
                                        _obscureTextConfirm
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    suffixIconColor:
                                        ColorConstants.formLabelTextColor,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      Map<String, String> body = {
                                        "password": _password,
                                      };

                                      var response =
                                          await APIService.updateNewPassword(body);


                                       if (response.statusCode == 200) {
                                         SharedService.logout(context);
                                         ScaffoldMessenger.of(context)
                                             .showSnackBar(const SnackBar(
                                             content: Text(
                                                 'New password set successfully. Please Log in.')));
                                         Navigator.pushAndRemoveUntil(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) =>
                                               const Login()),
                                               (route) => false,
                                         );
                                       } else if (response.statusCode == 404) {
                                        SharedService.logout(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Text(
                                                'User session has expired.')));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const Login()),
                                              (route) => false,
                                        );
                                      }
                                       else {
                                         final jsonData =
                                         json.decode(response.body);
                                         String message = jsonData['message'];
                                         ScaffoldMessenger.of(context)
                                             .showSnackBar(
                                             SnackBar(content: Text(message)));
                                       }
                                        // } else {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //           content: Text(
                                        //               'Failed to reset password.')));
                                        // }

                                    }
                                  },
                                  child: Text("Submit",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Bold',
                                      )),
                                  // style: ElevatedButton.styleFrom(
                                  //   primary: Color(0xFF5386E4),
                                  //   onPrimary: Colors.white,
                                  //   shape: StadiumBorder(),
                                  //   padding: EdgeInsets.only(
                                  //       top: 15.0, bottom: 15.0),
                                  // ),
                                  style: AuthConstants.getSubmitButtonStyle(),
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
            ),
          ],
        ),
      ),
    );
  }

  bool isPasswordValid(String password) {
    // Check if password is at least 8 characters long
    if (password.length < 8) {
      return false;
    }

    // Check if password contains at least one uppercase letter
    if (password.toLowerCase() == password) {
      return false;
    }

    // Check if password contains at least one lowercase letter
    if (password.toUpperCase() == password) {
      return false;
    }

    // Check if password contains at least one number
    if (!password.contains(new RegExp(r'[0-9]'))) {
      return false;
    }

    // Check if password contains at least one special character
    if (!password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    // If all checks pass, the password is valid
    return true;
  }
}
