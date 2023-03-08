import 'package:flutter/material.dart';

import 'package:we_panchayat_dev/main.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;

    emailController.text = "";
    passwordController.text = "";

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16),
                        TextFormField(
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
                          onPressed: () {},
                          child: Text("Log in",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Bold',
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF5386E4),
                            onPrimary: Colors.white,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        thickness: 0.8,
                        color: Colors.black54,
                      ),
                      Text(
                        "Don’t have an account? Sign up",
                        style: TextStyle(
                          color: Color(0xFF5386E4),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          fontFamily: 'Poppins-Bold',
                        ),
                        // Your bottom element goes here
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
