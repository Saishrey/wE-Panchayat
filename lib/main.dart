import 'dart:async';
import 'dart:io';

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:we_panchayat_dev/screens/splash.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as error_code;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

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

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      home: const Splash(),
      // routes: {
      //   '/' : (context) => const Splash(),
      //   '/login' : (context) => const Login(),
      //   '/signup' : (context) => const SignUp(),
      // },
    );
  }
}

