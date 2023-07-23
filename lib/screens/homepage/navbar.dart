import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/about/about.dart';
import 'package:we_panchayat_dev/screens/profile/user_profile.dart';
import 'package:we_panchayat_dev/screens/settings/settings.dart';
import 'dart:io';
import '../../models/login_response_model.dart';
import '../../services/auth_api_service.dart';
import '../../services/shared_service.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? _profile_pic;
  String? _email;
  String? _fullname;

  void _initProfilePic() async {
    File? file = await SharedService.getProfilePicture();
    if (file != null) {
      setState(() {
        _profile_pic = file;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initialiseDetails();
    _initProfilePic();
  }

  Future<void> _initialiseDetails() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    setState(() {
      _fullname = loginResponseModel?.fullname;
      _email = loginResponseModel?.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_fullname != null && _email != null) {
      return Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                _fullname!,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins-Bold',
                  color: Color(0xff21205b),
                ),
              ),
              accountEmail: Text(
                _email!,
                style: TextStyle(
                  color: Color(0xff356899),
                  fontFamily: "Poppins-Light",
                ),
              ),
              // currentAccountPicture: CircleAvatar(
              //   child: ClipOval(
              //     child: Image.asset(
              //       'assets/images/user_profile_blue.png',
              //       fit: BoxFit.cover,
              //       width: 90,
              //       height: 90,
              //     ),
              //   ),
              // ),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: _profile_pic != null
                    ? CircleAvatar(
                  // radius: 50,
                    backgroundImage: FileImage(_profile_pic!))
                    : CircleAvatar(
                  // radius: 20,
                  child: Image.asset('assets/images/user_profile_blue.png'),
                ),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.backgroundClipperColor,
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(130)),
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: NetworkImage(
                //       'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                // ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile()),
                  );
                },
                child: Ink(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.formBorderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 20,
                          color: Color(0xff2B2730),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 1,
                color: ColorConstants.formBorderColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                child: Ink(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.formBorderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 20,
                          color: Color(0xff2B2730),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 1,
                color: ColorConstants.formBorderColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                child: Ink(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.formBorderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Color(0xff2B2730),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: InkWell(
                onTap: () async {
                  bool isLoggedOut = await APIService.logout(context);
                  if (isLoggedOut) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out.')));
                  }
                },
                child: Ink(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.formBorderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.logout,
                          size: 20,
                          color: Color(0xff2B2730),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14,
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
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "NAME",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins-Bold',
                color: Color(0xff21205b),
              ),
            ),
            accountEmail: Text(
              "EMAIL",
              style: TextStyle(
                color: Color(0xff356899),
                fontFamily: "Poppins-Light",
              ),
            ),
            // currentAccountPicture: CircleAvatar(
            //   child: ClipOval(
            //     child: Image.asset(
            //       'assets/images/user_profile_blue.png',
            //       fit: BoxFit.cover,
            //       width: 90,
            //       height: 90,
            //     ),
            //   ),
            // ),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                      // radius: 20,
                      child: Image.asset('assets/images/user_profile_blue.png'),
                    ),
            ),
            decoration: BoxDecoration(
              color: ColorConstants.backgroundClipperColor,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(130)),
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: NetworkImage(
              //       'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
              // ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: Ink(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorConstants.formBorderColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Color(0xff2B2730),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: Text(
                        'My Profile',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Poppins-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              color: ColorConstants.formBorderColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Ink(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorConstants.formBorderColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.settings,
                        size: 20,
                        color: Color(0xff2B2730),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Poppins-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              color: ColorConstants.formBorderColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              child: Ink(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorConstants.formBorderColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Color(0xff2B2730),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: Text(
                        'About',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Poppins-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: InkWell(
              onTap: () async {
                bool isLoggedOut = await APIService.logout(context);
                if (isLoggedOut) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out.')));
                }
              },
              child: Ink(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorConstants.formBorderColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.logout,
                        size: 20,
                        color: Color(0xff2B2730),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Poppins-Medium',
                          fontSize: 14,
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
