import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/screens/about/about.dart';
import 'package:we_panchayat_dev/screens/profile/user_profile.dart';
import 'package:we_panchayat_dev/screens/settings/settings.dart';

import '../../models/login_response_model.dart';
import '../../services/api_service.dart';
import '../../services/shared_service.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: userName(),
            accountEmail: email(),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/user_profile_blue.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
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
                    const SizedBox(width: 32,),
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
                    const SizedBox(width: 32,),
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
                    const SizedBox(width: 32,),
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Logged out.')));
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
                    const SizedBox(width: 32,),
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

  Widget userName() {
    return FutureBuilder(
      future: SharedService.loginDetails(),
      builder:
          (BuildContext context, AsyncSnapshot<LoginResponseModel?> model) {
        if (model.hasData) {
          return Text(
            getUserName(model.data)!,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins-Bold',
              color: Color(0xff21205b),
            ),
          );
        }

        return Text(
          "USER NAME",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins-Bold',
            color: Color(0xff21205b),
          ),
        );
      },
    );
  }

  Widget email() {
    return FutureBuilder(
      future: SharedService.loginDetails(),
      builder:
          (BuildContext context, AsyncSnapshot<LoginResponseModel?> model) {
        if (model.hasData) {
          return Text(
            getEmail(model.data)!,
            style: TextStyle(
              color: Color(0xff356899),
              fontFamily: "Poppins-Light",
            ),
          );
        }
        return Text(
          "EMAIL",
        );
      },
    );
  }

  String? getUserName(LoginResponseModel? model) {
    print("Username: ${model?.fullname}");

    if (model?.fullname == null) {
      return "NULL";
    }
    return model?.fullname;
  }

  String? getEmail(LoginResponseModel? model) {
    print("Username: ${model?.email}");

    if (model?.email == null) {
      return "NULL";
    }
    return model?.email;
  }
}
