import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/screens/auth/login.dart';
import '../constants.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';
import 'homepage/homepage.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as error_code;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  // bool isDeviceSupport = false;
  // List<BiometricType>? availableBiometrics;
  // LocalAuthentication? auth;

  var connectivityResult;

  bool _isConnectedToInternet = true;

  void checkLoginSession() async {
    bool result = await SharedService.isLoggedIn();

    if (result) {
      print("User ALREADY logged in.");

      int isSessionActive = await APIService.checkSession(context);

      await Future.delayed(Duration(seconds: 1));

      if (isSessionActive == 0) {
        showSessionExpiryDialogBox();
      } else if (isSessionActive == 1) {
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
      // else {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text('Could not establish connection with server.'),
      //         content: Text('Please try again later.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               // SharedService.logout(context);
      //               SystemNavigator.pop();
      //             },
      //             child: Text('OK'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
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

    // auth = LocalAuthentication();

    // deviceCapability();
    // _getAvailableBiometrics();

    checkInternet();

    requestPermission();

    checkLoginSession();
  }

  Future<void> requestPermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      // Request permission
      await Permission.storage.request();
    }
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showConnectivityDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  Future<void> checkInternet() async {
    await Future.delayed(Duration(seconds: 1));
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnectedToInternet = false;
      });
      showConnectivityDialogBox();
    } else {
      await Future.delayed(Duration(seconds: 1));
    }
  }



  showConnectivityDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'No Internet Connection',
            style: AlertDialogBoxConstants.getTitleTextStyle(),
          ),
          content: Text(
            'Please check your internet connection and try again.',
            style: AlertDialogBoxConstants.getContentTextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                SystemNavigator.pop();
              },
              child: Text(
                'OK',
                style: AlertDialogBoxConstants.getButtonTextStyle(),
              ),
            ),
          ],
        ),
      );

  showSessionExpiryDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'Session Expired',
            style: AlertDialogBoxConstants.getTitleTextStyle(),
          ),
          content: Text(
            'Please log in again.',
            style: AlertDialogBoxConstants.getContentTextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                SharedService.logout(context);
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text(
                'OK',
                style: AlertDialogBoxConstants.getButtonTextStyle(),
              ),
            ),
          ],
        ),
      );

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

  // Future<void> _getAvailableBiometrics() async {
  //   try {
  //     availableBiometrics = await auth?.getAvailableBiometrics();
  //     print("bioMetric: $availableBiometrics");
  //
  //     if (availableBiometrics!.contains(BiometricType.strong) || availableBiometrics!.contains(BiometricType.fingerprint)) {
  //       final bool didAuthenticate = await auth!.authenticate(
  //           localizedReason: 'Unlock your screen   face  or fingerprint',
  //           options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
  //           authMessages: const <AuthMessages>[
  //             AndroidAuthMessages(
  //               signInTitle: 'wepanchayat',
  //               cancelButton: 'No thanks',
  //             ),
  //             IOSAuthMessages(
  //               cancelButton: 'No thanks',
  //             ),
  //           ]);
  //       if (!didAuthenticate) {
  //         exit(0);
  //       }
  //     } else if (availableBiometrics!.contains(BiometricType.weak) || availableBiometrics!.contains(BiometricType.face)) {
  //       final bool didAuthenticate = await auth!.authenticate(
  //           localizedReason: 'Unlock your screen with  face  or fingerprint',
  //           options: const AuthenticationOptions(stickyAuth: true),
  //           authMessages: const <AuthMessages>[
  //             AndroidAuthMessages(
  //               signInTitle: 'wepanchayat',
  //               cancelButton: 'No thanks',
  //             ),
  //             IOSAuthMessages(
  //               cancelButton: 'No thanks',
  //             ),
  //           ]);
  //       if (!didAuthenticate) {
  //         exit(0);
  //       }
  //     }
  //   } on PlatformException catch (e) {
  //     // availableBiometrics = <BiometricType>[];
  //     if (e.code == error_code.passcodeNotSet) {
  //       exit(0);
  //     }
  //     print("error: $e");
  //   }
  // }
  //
  // void deviceCapability() async {
  //   final bool isCapable = await auth!.canCheckBiometrics;
  //   isDeviceSupport = isCapable || await auth!.isDeviceSupported();
  // }
}
