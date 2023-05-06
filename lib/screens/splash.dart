import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage/homepage.dart';
import 'package:connectivity/connectivity.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var connectivityResult;

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  Future<void> checkInternet() async {
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please check your internet connection and try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        },
      );
    }
    else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              // builder: (context) => const MyHomePage(
              //       title: 'wE-Panchayat',
              //     )
              builder: (context) => const Home(),
            ));
      });
    }
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
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
        // CircularProgressIndicator(),
      ),
    );
  }
}
