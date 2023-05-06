import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:we_panchayat_dev/screens/splash.dart';
import 'package:we_panchayat_dev/screens/splashLogin.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import 'package:permission_handler/permission_handler.dart';


Widget _defaultHome = const SplashLogin();

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
Future<void> requestPermission() async {
  // var status = await Permission.storage.status;
  // if (status.isDenied) {
  //   // Request permission
  //   await Permission.storage.request();
  // }

  var status = await Permission.manageExternalStorage.status;
  if (status.isDenied) {
    // Request permission
    await Permission.storage.request();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  requestPermission();

  bool _result = await SharedService.isLoggedIn();

  if(_result) {
    print("User ALREADY logged in.");
    _defaultHome = const Splash();
    // await flutterLocalNotificationsPlugin.initialize(
    //   const InitializationSettings(
    //     android: AndroidInitializationSettings('app_icon'),
    //   ),
    // );
  }
  else {
    print("User NOT logged in");
    await APICacheManager().deleteCache("cookie_headers");
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

