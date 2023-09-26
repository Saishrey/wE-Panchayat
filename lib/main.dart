import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:we_panchayat_dev/screens/splash.dart';
import 'package:privacy_screen/privacy_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  Future<void> _enablePrivacyScreen() async {
    await PrivacyScreen.instance.enable(
      iosOptions: const PrivacyIosOptions(
        enablePrivacy: true,
        privacyImageName: "LaunchImage",
        autoLockAfterSeconds: 5,
        lockTrigger: IosLockTrigger.didEnterBackground,
      ),
      androidOptions: const PrivacyAndroidOptions(
        enableSecure: true,
        autoLockAfterSeconds: 5,
      ),
      backgroundColor: Colors.red.withOpacity(0.4),
      blurEffect: PrivacyBlurEffect.dark,
    );
  }

  @override
  void initState() {
    super.initState();
    _enablePrivacyScreen();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wE-Panchayat',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffDDF0FF),
          foregroundColor: Color(0xff22215B),
        ),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlueAccent.shade200,
      ),
      navigatorKey: navigatorKey,
      builder: (_, child) {
        return PrivacyGate(
          navigatorKey: navigatorKey,
          onLifeCycleChanged: (value) => print(value),
          child: child,
        );
      },
      home: const Splash(),
      // routes: {
      //   '/' : (context) => const Splash(),
      //   '/login' : (context) => const Login(),
      //   '/signup' : (context) => const SignUp(),
      // },
    );
  }
}
