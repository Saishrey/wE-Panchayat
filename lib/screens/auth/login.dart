import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/models/login_request_model.dart';
import 'package:we_panchayat_dev/screens/auth/signup_mobile_input.dart';

import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/services/auth_api_service.dart';

import 'package:we_panchayat_dev/screens/auth/signup.dart';

import 'package:we_panchayat_dev/screens/otp/otp.dart';
import 'package:we_panchayat_dev/screens/reset_password/username_input.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAPIcallProcess = false;

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  // String? _password;
  String? _previousUsername;

  final Map<String, String> _usernameRegex = {
    'email': r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    'phone': r"^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$",
  };

  Map<String, int> _usernameRecord = {};

  String _usernameLabelText = 'Email or Phone';

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _previousUsername = "!";
    // _usernameController.addListener(_checkUsernameChanged);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  bool _checkUsernameChanged() {
    print("Check if username changed");
    print(_usernameController.text);
    print(_previousUsername);
    if (_usernameController.text != _previousUsername) {
      // Value has changed
      print('Value changed: ${_usernameController.text}');
      _previousUsername = _usernameController.text;
      return true;
    }
    return false;
  }

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
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    print("Username : $value");

                                    return null;
                                  },
                                  onChanged: (value) {
                                    if(_checkEmailOrPhone(value) == 1) {
                                      setState(() {
                                        _usernameLabelText = 'Email';
                                      });
                                    }
                                    else if(_checkEmailOrPhone(value) == 2) {
                                      setState(() {
                                        _usernameLabelText = 'Phone';
                                      });
                                    }
                                    else {
                                      setState(() {
                                        _usernameLabelText = 'Email or Phone';
                                      });
                                    }
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  decoration: InputDecoration(
                                    labelText: _usernameLabelText,
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: AuthConstants.getEnabledBorder(),
                                    enabledBorder:
                                        AuthConstants.getEnabledBorder(),
                                    focusedBorder:
                                        AuthConstants.getFocusedBorder(),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    print("Password : $value");
                                    return null;
                                  },
                                  style: AuthConstants.getTextStyle(),
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    suffixIconColor:
                                        ColorConstants.formLabelTextColor,
                                    labelStyle:
                                        AuthConstants.getLabelAndHintStyle(),
                                    // filled: true,
                                    // fillColor: Color(0xffF6F6F6),
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
                                      if (_checkUsernameChanged()) {
                                        if (!_usernameRecord.containsKey(
                                            _usernameController.text)) {
                                          setState(() {
                                            _usernameRecord[
                                                _usernameController.text] = 3;
                                          });
                                        }
                                      }

                                      LoginRequestModel model = LoginRequestModel(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                          isAdmin: false.toString());

                                      var response =
                                          await APIService.login(model);

                                      if (response.statusCode == 200) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Otp()));
                                      } else if (response.statusCode == 404) {
                                        final jsonData =
                                            json.decode(response.body);
                                        // Access the "message" key
                                        String message = jsonData['message'];

                                        if (message ==
                                            "User is blocked. Please reset password to verify and login") {
                                          showAccountBlockedDialogBox();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(message),
                                            ),
                                          );
                                        }
                                      } else if (response.statusCode == 401) {
                                        setState(() {
                                          _usernameRecord[_usernameController
                                              .text] = (_usernameRecord[
                                                  _usernameController.text]! -
                                              1);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Invalid credentials.'),
                                          ),
                                        );

                                        // WARN USER
                                        if (_usernameRecord[
                                                _usernameController.text] ==
                                            1) {
                                          showWarningDialogBox();
                                        }

                                        // BLOCK USER
                                        if (_usernameRecord[
                                                _usernameController.text] ==
                                            0) {
                                          Map<String, String> body = {
                                            'username': _usernameController.text,
                                          };

                                          var response =
                                              await APIService.blockAccount(body);

                                          if (response.statusCode == 200) {
                                            showAccountBlockedDialogBox();
                                          }
                                        }
                                      }
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Invalid credentials.'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text("Log in",
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
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
                    //   child: Divider(
                    //     height: 1,
                    //     thickness: 0.8,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0, right: 10.0, left: 10.0, bottom: 40.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UsernameInput()),
                            );
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: ColorConstants.colorHuntCode2,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: 'Poppins-Medium',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 0.8,
                    color: ColorConstants.formBorderColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: InkWell(
                      onTap: () {},
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            "Don’t have an account? Sign up",
                            style: TextStyle(
                              color: ColorConstants.colorHuntCode2,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: 'Poppins-Medium',
                            ),
                            // Your bottom element goes here
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignUpMobileInput()),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showWarningDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'Warning',
            style: AlertDialogBoxConstants.getTitleTextStyle(),
          ),
          content: Text(
            'You have only 1 attempt left to log in.',
            style: AlertDialogBoxConstants.getContentTextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // SharedService.logout(context);
                Navigator.of(context).pop();
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Login(),
                //   ),
                // );
              },
              child: Text(
                'OK',
                style: AlertDialogBoxConstants.getButtonTextStyle(),
              ),
            ),
          ],
        ),
      );


  int _checkEmailOrPhone(String value) {
    if(RegExp(r"^[789]\d{9}$").hasMatch(value)) {
      return 2;
    } else if (RegExp(
        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 1;
    }
    return 0;
  }


  showAccountBlockedDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'Account Blocked',
            style: AlertDialogBoxConstants.getTitleTextStyle(),
          ),
          content: Text(
            'Please reset your password to log in by clicking on forgot password link.',
            style: AlertDialogBoxConstants.getContentTextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // SharedService.logout(context);
                Navigator.of(context).pop();
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Login(),
                //   ),
                // );
              },
              child: Text(
                'OK',
                style: AlertDialogBoxConstants.getButtonTextStyle(),
              ),
            ),
          ],
        ),
      );
}
