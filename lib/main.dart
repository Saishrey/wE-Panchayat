import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:we_panchayat_dev/screens/splash.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

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

  var isLogin = false;

  ConnectivityResult? _connectivityResult;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
      if (result == ConnectivityResult.none) {
        showNoInternetDialog();
      }
    });
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetDialog();
    }
  }

  Future<void> showNoInternetDialog() async {
    await showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("No Internet Connection"),
        content: Text("Please check your internet connection."),
        actions: [
          BasicDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            title: Text("OK"),
          ),
        ],
      ),
    );
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
        accentColor: Colors.purpleAccent.shade700,
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

