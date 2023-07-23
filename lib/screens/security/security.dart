import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/screens/security/mpin_create.dart';
import 'package:we_panchayat_dev/screens/security/mpin_disable.dart';

import '../../constants.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isMPINEnabled = false;

  bool _isAppLockEnabled = false;

  Future<bool> getAppLockState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('appLockEnabled') ?? false;
    return isEnabled;
  }

  Future<void> setAppLockState(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appLockEnabled', isEnabled);
  }

  Future<bool> getMPINState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('mpinEnabled') ?? false;
    return isEnabled;
  }

  Future<void> setMPINState(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mpinEnabled', isEnabled);
  }

  @override
  void initState() {
    super.initState();
    getAppLockState().then((isEnabled) {
      setState(() {
        _isAppLockEnabled = isEnabled;
      });
    });
    getMPINState().then((isEnabled) {
      setState(() {
        _isMPINEnabled = isEnabled;
      });
    });
  }

  void toggleAppLock(bool value) {
    // setAppLockState(value).then((_) {
    //   setState(() {
    //     _isAppLockEnabled = value;
    //   });
    // });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DisableMPINScreen()),
    );
  }

  void toggleMPIN(bool value) {
    setMPINState(value).then((_) {
      setState(() {
        _isMPINEnabled = value;
      });
    });
  }

  void _handleMPINRadioChanged(bool? value) {
    setState(() {
      _isMPINEnabled = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: ColorConstants.backgroundClipperColor,
        // ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: ColorConstants.lightBlackColor,

        elevation: 0,
      ),
      body: ListView(
        children: [

          Container(
            padding:
                const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
            child: const Text(
              'Security',
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
              'Set your app lock to protect your wE-Panchayat app using MPIN to secure access to your account',
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
                if(!_isAppLockEnabled) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateMPINScreen(isSignUp: false)),
                  );
                  // toggleAppLock(true);
                }

              },
              child: Ink(
                child: RadioListTile(
                  value: true,
                  activeColor: ColorConstants.lightBlueThemeColor,
                  groupValue: _isAppLockEnabled ? _isMPINEnabled : null,
                  onChanged: _isAppLockEnabled ? _handleMPINRadioChanged : null,
                  title: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      "Use MPIN lock",
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 16,
                        color: Color(0xff2B2730),
                      ),
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      "Use a 4-digit MPIN to protect your wE-Panchayat app",
                      style: TextStyle(
                        fontFamily: 'Poppins-Light',
                        fontSize: 12,
                        color: Color(0xff2B2730),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: SwitchListTile(
              title: Text(
                'Disable app lock',
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 16,
                  color: _isAppLockEnabled ? Color(0xff2B2730) : Colors.black54,
                ),
              ),
              subtitle: Text(
                'Remove all your app lock settings',
                style: TextStyle(
                  fontFamily: 'Poppins-Light',
                  fontSize: 12,
                  color: _isAppLockEnabled ? Color(0xff2B2730) : Colors.black54,
                ),
              ),
              value: _isAppLockEnabled,
              onChanged: _isAppLockEnabled ? toggleAppLock : null,
              activeColor: ColorConstants.lightBlueThemeColor,
            ),
          ),
        ],
      ),
    );
  }
}
