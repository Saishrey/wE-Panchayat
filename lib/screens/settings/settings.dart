import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isAppLockEnabled = false;

  Future<bool> getAppLockState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('appLockEnabled') ?? false;
    return isEnabled;
  }


  Future<void> setAppLockState(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appLockEnabled', isEnabled);
  }


  @override
  void initState() {
    super.initState();
    getAppLockState().then((isEnabled) {
      setState(() {
        isAppLockEnabled = isEnabled;
      });
    });
  }

  void toggleAppLock(bool value) {
    setAppLockState(value).then((_) {
      setState(() {
        isAppLockEnabled = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffDDF0FF),
        foregroundColor: ColorConstants.darkBlueThemeColor,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(

                    child: Icon(Icons.fingerprint, size: 40, color: Colors.black54,),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: Text(
                      'Biometric Authentication',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 14,
                        color: ColorConstants.darkBlueThemeColor,
                      ),
                    ),
                    value: isAppLockEnabled,
                    onChanged: toggleAppLock,
                    activeColor: ColorConstants.lightBlueThemeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
