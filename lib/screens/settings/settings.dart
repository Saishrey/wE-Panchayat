import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_panchayat_dev/screens/security/security.dart';

import '../../constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorConstants.backgroundClipperColor,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: ColorConstants.darkBlueThemeColor,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
            child: const Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontSize: 26,
                color: Color(0xff2B2730),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: const Text(
              'General app settings',
              style: TextStyle(
                fontFamily: 'Poppins-Light',
                fontSize: 15,
                color: Color(0xff2B2730),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print("Tapped on security");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecurityPage()),
                );
              },
              child: Ink(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffDDF7E3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.lock_outline,
                            size: 45,
                            color: ColorConstants.submitGreenColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Security',
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            color: Color(0xff2B2730),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
