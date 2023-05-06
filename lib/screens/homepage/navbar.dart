import 'package:flutter/material.dart';

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
                  'assets/images/user_icon.jpeg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xffDDF0FF),
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: NetworkImage(
              //       'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
              // ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Personal Info'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Applications'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.warning),
            title: Text('Grievances'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () async {
              bool isLoggedOut = await APIService.logout(context);
              if(isLoggedOut) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Logged out.')));
              }
            },
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
