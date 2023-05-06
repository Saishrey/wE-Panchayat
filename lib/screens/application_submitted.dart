import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'homepage/homepage.dart';

class ApplicationSubmitted extends StatefulWidget {
  const ApplicationSubmitted({Key? key}) : super(key: key);

  @override
  State<ApplicationSubmitted> createState() => _ApplicationSubmittedState();
}

class _ApplicationSubmittedState extends State<ApplicationSubmitted> {

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
            builder: (context) => const Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // child: Lottie.network(
              //   "https://assets7.lottiefiles.com/private_files/lf30_poez9ped.json",
              //   repeat: false,
              // ),
              child: LottieBuilder.asset(
                'assets/animations/application-submitted-animation.json',
                // You can also use `animationData` instead of the asset path
                // animationData,
                repeat: false,
                reverse: false,
                animate: true,
              ),
            ),
            SizedBox(height: 16),
            const Text(
              'Congratulations',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xff407AFF),
              ),
            ),
            SizedBox(height: 16),
            const Text(
              'Your application has been submitted successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7b7f9e),
              ),
            ),
          ],
        ),
    );
  }
}