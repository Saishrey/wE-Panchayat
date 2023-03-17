import 'package:flutter/material.dart';

import 'package:we_panchayat_dev/main.dart';

import 'package:we_panchayat_dev/auth/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;

    emailController.text = "";
    passwordController.text = "";

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
                                      return "Please Enter Email";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return "Please Enter a Valid Email";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
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
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter password ";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffF6F6F6),
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
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()),
                                      );
                                    }
                                  },
                                  child: Text("Log in",
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
                      child: Divider(
                        height: 1,
                        thickness: 0.8,
                        color: Colors.black54,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Forgot your password?",
                                style: TextStyle(
                                  color: Color(0xFF5386E4),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  fontFamily: 'Poppins-Bold',
                                ),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (context) => linkScreen),
                                //     );
                                //   },
                              ),
                            ],
                          ),
                        )),
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
                            "Don’t have an account? Sign up",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
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
