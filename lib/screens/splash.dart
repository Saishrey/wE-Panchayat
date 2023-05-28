import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:we_panchayat_dev/screens/auth/login.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';
import 'homepage/homepage.dart';
import 'package:connectivity/connectivity.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var connectivityResult;

  void checkLoginDetails() async {
    bool result = await SharedService.isLoggedIn();

    if (result) {
      print("User ALREADY logged in.");

      int isSessionActive = await APIService.checkSession(context);

      await Future.delayed(Duration(seconds: 1));

      if (isSessionActive == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Session Expired'),
              content: Text('Please log in again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    SharedService.logout(context);
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if(isSessionActive == 1){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            // builder: (context) => const MyHomePage(
            //       title: 'wE-Panchayat',
            //     )
            builder: (context) => Home(),
          ),
        );
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not establish connection with server.'),
              content: Text('Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    SharedService.logout(context);
                    SystemNavigator.pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      print("User NOT logged in");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // builder: (context) => const MyHomePage(
          //       title: 'wE-Panchayat',
          //     )
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    checkInternet();

    requestPermission();

    checkLoginDetails();
  }

  Future<void> requestPermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      // Request permission
      await Permission.storage.request();
    }
  }

  Future<void> checkInternet() async {
    await Future.delayed(Duration(seconds: 1));
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content:
                Text('Please check your internet connection and try again.'),
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
    } else {
      await Future.delayed(Duration(seconds: 1));
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
              child: CircularProgressIndicator(),
            ),
          ],
        ),
        // CircularProgressIndicator(),
      ),
    );
  }
}
