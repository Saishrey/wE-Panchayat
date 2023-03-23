import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/models/login_request_model.dart';

import 'package:we_panchayat_dev/screens/homepage/homepage.dart';
import 'package:we_panchayat_dev/screens/reset_password/reset_password.dart';
import 'package:we_panchayat_dev/services/api_service.dart';

import 'package:we_panchayat_dev/screens/auth/signup.dart';

import 'package:we_panchayat_dev/screens/auth/login.dart';


import 'package:we_panchayat_dev/screens/otp/otp.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  _UsernameInputState createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  bool isAPIcallProcess = false;

  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  String? _username;

  final Map<String, String> _usernameRegex = {
    'email': r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    'phone': r"^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$",
  };

  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;

    usernameController.text = "";

    return Container(
      padding: EdgeInsets.only(top: 60.0),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
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
                      'Forgot Password',
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
                      child: const Text(
                        'Enter your email or mobile number for verification process, we will send you a 6 digits code.',
                        textAlign: TextAlign.center,
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
                                    }
                                    _username = value;
                                    print("Username : $_username");

                                    return null;
                                  },
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email or Phone',
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
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const ResetPassword()));
                                  },
                                  child: Text("Submit",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Bold',
                                      )),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF5386E4),
                                    onPrimary: Colors.white,
                                    shape: StadiumBorder(),
                                    padding: EdgeInsets.only(
                                        top: 15.0, bottom: 15.0),
                                  ),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 0.8,
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: InkWell(
                      onTap: () {},
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            "Already have an account? Log in",
                            style: TextStyle(
                              color: Color(0xFF5386E4),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              fontFamily: 'Poppins-Bold',
                            ),
                            // Your bottom element goes here
                          ),
                        ),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                                (route) => false,
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
}
