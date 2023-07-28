import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/screens/auth/login.dart';
import 'package:we_panchayat_dev/screens/dialog_boxes.dart';
import 'package:we_panchayat_dev/screens/security/mpin_enter.dart';
import '../constants.dart';
import '../services/auth_api_service.dart';
import '../services/shared_service.dart';
import 'homepage/homepage.dart';
import 'package:connectivity/connectivity.dart';

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

  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate',
      options: const AuthenticationOptions(biometricOnly: true),
    );
    if (didAuthenticate) {
      Navigator.pop(context);
    }
  }

  showPinDialogue(BuildContext context, String mpin) => showDialog<void>(
        context: context,
        builder: (context) {
          return ScreenLock(
            correctString: mpin,
            onCancelled: Navigator.of(context).pop,
            onUnlocked: () async {
              await Future.delayed(Duration(milliseconds: 250));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            }
          );
        },
      );

  Future<bool> getAppLockState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('appLockEnabled') ?? false;
    return isEnabled;
  }

  Future<bool> getMPINState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('mpinEnabled') ?? false;
    return isEnabled;
  }

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;

    try {
      androidInfo = await deviceInfo.androidInfo;
    } catch (e) {
      print('Error retrieving Android device info: $e');
    }

    if(androidInfo != null) {
      // print('Device ID: ${androidInfo.id}');
      // print('Manufacturer: ${androidInfo.manufacturer}');
      print('Model: ${androidInfo.model}');
      // print('Device: ${androidInfo.device}');
      // print('Brand: ${androidInfo.brand}');
      // print('Host: ${androidInfo.host}');
      // print('Manufacturer: ${androidInfo.manufacturer}');
      // print('Product: ${androidInfo.product}');
      // print('Version: ${androidInfo.version.baseOS}');

      Map<String, String> androidInfoJson = {
      // 'id': androidInfo.id,
      // 'manufacturer': androidInfo.manufacturer,
      'Device-Info': androidInfo.model,
      // 'device': androidInfo.device,
      // 'brand': androidInfo.brand,
      // 'host': androidInfo.host,
      // 'product': androidInfo.product,
      // 'version': androidInfo.version.baseOS,
      };

      String jsonStr = json.encode(androidInfoJson);
      print(jsonStr);

      await SharedService.setDeviceHeader(androidInfoJson);
    }



    IosDeviceInfo? iosInfo;

    try {
      iosInfo = await deviceInfo.iosInfo;
    } catch (e) {
      print('Error retrieving iOS device info: $e');
    }

    if(iosInfo != null) {
      print('Running on ${iosInfo.utsname.machine}');

      Map<String, String> iosInfoJson = {
        'Device-Info': iosInfo.utsname.machine,
      };

      String jsonStr = json.encode(iosInfoJson);
      print(jsonStr);

      await SharedService.setDeviceHeader(iosInfoJson);
    }
  }

  void checkLoginSession() async {
    bool result = await SharedService.isLoggedIn();

    if (result) {
      print("User ALREADY logged in.");

      int isSessionActive = await APIService.checkSession(context);

      await Future.delayed(Duration(seconds: 1));

      if (isSessionActive == 0) {
        DialogBoxes.showSessionExpiryDialogBox(context);
      } else if (isSessionActive == 1) {
        bool isAppLockEnabled = await getAppLockState();

        bool isMPINEnabled = await getMPINState();


        if(isAppLockEnabled) {
          if(isMPINEnabled) {
            // String? mpin = await SharedService.getMPIN();
            // showPinDialogue(context, mpin!);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                // builder: (context) => const MyHomePage(
                //       title: 'wE-Panchayat',
                //     )
                builder: (context) => EnterMPINScreen(),
              ),
            );
          }
        }
        else {
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

    getDeviceInfo();

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
            DialogBoxes.showConnectivityDialogBox(context);
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
      DialogBoxes.showConnectivityDialogBox(context);
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: LinearProgressIndicator(minHeight: 8,),
              ),
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
