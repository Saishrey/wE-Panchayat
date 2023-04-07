import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';

import 'auth/login.dart';
import 'auth/signup.dart';

import 'homepage/homepage.dart';

class SplashLogin extends StatefulWidget {
  const SplashLogin({Key? key}) : super(key: key);

  @override
  State<SplashLogin> createState() => _SplashLoginState();
}

class _SplashLoginState extends State<SplashLogin> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              // builder: (context) => const MyHomePage(
              //       title: 'wE-Panchayat',
              //     )
            builder: (context) => const Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_with_di.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              height: 200.0,
              width: 200.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text(
                'wE-Panchayat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff21205b),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                'An M-Governance platform of \nPanchayati Raj Instituitions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff7b7f9e),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
        // CircularProgressIndicator(),
      ),
    );
  }
}
