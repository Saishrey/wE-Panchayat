import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_panchayat_dev/screens/auth/login.dart';
import 'package:we_panchayat_dev/screens/auth/signup.dart';
import 'package:we_panchayat_dev/screens/homepage/homepage.dart';

import 'package:we_panchayat_dev/screens/splash.dart';
import 'package:we_panchayat_dev/screens/splashLogin.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';

Widget _defaultHome = const SplashLogin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();

  if(_result) {
    _defaultHome = const Splash();
  }

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

  var isLogin = false;

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
        accentColor: Colors.purpleAccent.shade700,
      ),
      home: _defaultHome,
      // routes: {
      //   '/' : (context) => const Splash(),
      //   '/login' : (context) => const Login(),
      //   '/signup' : (context) => const SignUp(),
      // },
    );
  }

}

