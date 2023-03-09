import 'dart:async';

import 'package:flutter/material.dart';

import 'main.dart';

import 'auth/login.dart';
import 'auth/signup.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
            builder: (context) => const Login()
          ));
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: AssetImage('assets/images/bg.png'),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //     child: Scaffold(
  //       backgroundColor: Colors.transparent,
  //       body: Stack(
  //         children: [
  //           Positioned(
  //             top: 0,
  //             left: 0,
  //             child: Image(image: AssetImage('assets/images/icon.png')),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   double baseWidth = 375;
  //   double fem = MediaQuery.of(context).size.width / baseWidth;
  //   double ffem = fem * 0.97;
  //
  //   return Scaffold(
  //     body: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       decoration: const BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage('assets/images/bg.png'),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       child: Scaffold(
  //         backgroundColor: Colors.transparent,
  //         body: Container(
  //           // splashscreenRhi (4:236)
  //           padding:  EdgeInsets.fromLTRB(65*fem, 200*fem, 65*fem, 84*fem),
  //           width:  double.infinity,
  //           decoration:  BoxDecoration (
  //             color:  Colors.transparent,
  //           ),
  //           child:
  //           Column(
  //             crossAxisAlignment:  CrossAxisAlignment.center,
  //             children:  [
  //               Container(
  //                 // logo11GiL (4:244)
  //                 margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
  //                 width:  216*fem,
  //                 height:  215*fem,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     image: AssetImage('assets/images/icon.png'),
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 // wepanchayatPHA (4:245)
  //                 margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
  //                 child:
  //                 Text(
  //                   'wE-Panchayat',
  //                   textAlign:  TextAlign.center,
  //                   style:  TextStyle (
  //                     fontSize:  32*ffem,
  //                     fontWeight:  FontWeight.w700,
  //                     height:  1.5*ffem/fem,
  //                     color:  Color(0xff21205b),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 // anmgovernanceplatformofpanchay (4:246)
  //                 margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 20*fem),
  //                 constraints:  BoxConstraints (
  //                   maxWidth:  245*fem,
  //                 ),
  //                 child:
  //                 Text(
  //                   'An M-Governance platform of \nPanchayati Raj Instituitions',
  //                   textAlign:  TextAlign.center,
  //                   style:  TextStyle (
  //                     fontSize:  16*ffem,
  //                     fontWeight:  FontWeight.w400,
  //                     height:  1.5429999828*ffem/fem,
  //                     color:  Color(0xff7b7f9e),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 // digitalindialogo18e4 (4:243)
  //                 margin:  EdgeInsets.fromLTRB(0*fem, 40*fem, 0*fem, 0*fem),
  //                 width:  170*fem,
  //                 height:  95*fem,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     image: AssetImage('assets/images/digital_india.png'),
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

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
