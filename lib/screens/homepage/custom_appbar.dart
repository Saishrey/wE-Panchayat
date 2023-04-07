import 'package:flutter/material.dart';

import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String imageUrl;
  final VoidCallback onDrawerIconTap;

  const CustomAppBar({
    Key? key,
    required this.imageUrl,
    required this.onDrawerIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Image.asset(
          imageUrl,
          // height: 60,
          // width: 60,
        ),
      ),
      title: villageName(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            // icon: Icon(Icons.person),
            icon: ClipOval(
              child: Image.asset(
                'assets/images/user_icon.jpeg',
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget userName() {
    return FutureBuilder(
      future: SharedService.loginDetails(),
      builder:
          (BuildContext context, AsyncSnapshot<LoginResponseModel?> model) {
        if (model.hasData) {
          return Text(
            getUserName(model.data)!,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Color(0xff21205b),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          );
        }

        return Text(
          "USER NAME",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Color(0xff21205b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
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

  Widget villageName() {
    return FutureBuilder(
      future: SharedService.loginDetails(),
      builder:
          (BuildContext context, AsyncSnapshot<LoginResponseModel?> model) {
        if (model.hasData) {
          return Text(
            getVillage(model.data)!,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Color(0xff21205b),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          );
        }

        return Text(
          "USER NAME",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Color(0xff21205b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        );
      },
    );
  }

  String? getVillage(LoginResponseModel? model) {
    print("Username: ${model?.village}");

    if (model?.village == null) {
      return "NULL";
    }
    return "${model?.village}";
  }
}
