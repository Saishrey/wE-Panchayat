import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_panchayat_dev/screens/security/security.dart';

import '../../constants.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: ColorConstants.backgroundClipperColor,
        // ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: ColorConstants.darkBlueThemeColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
            child: const Text(
              'About wE-Panchayat',
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontSize: 26,
                color: Color(0xff2B2730),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(
                              0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "wE-panchayat is a mobile application designed to bridge the gap between the Panchayat and the community it serves. wE-panchayat aims to provide seamless and user friendly platform for citizens to engage with their local panchayat. We believe empowering community by means of transperant and efficient governance.",
                            style: TextStyle(
                              fontFamily: 'Poppins-Light',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Benefits to Citizens",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 16,
                              color: ColorConstants.lightBlackColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "1.",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "Stay Informed: Access up-to-date information about your Panchayat, including details about  upcoming meetings, events, and announcements.",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "2.",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "Grievance Redressal: Report issues or concerns directly through the app, ensuring efficient resolution and tracking of grievances. Our dedicated team is committed to addressing your concerns and improving the quality of public services.",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "3.",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "Public Services Made Easy: Simplify your interactions with the Panchayat by accessing a range of public services directly from your mobile device. Apply for essential certificates, pay property taxes, or submit relevant forms seamlessly.",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
