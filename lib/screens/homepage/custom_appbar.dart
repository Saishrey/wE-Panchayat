import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/constants.dart';

import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onDrawerIconTap;

  const CustomAppBar({
    Key? key,
    required this.imageUrl,
    required this.onDrawerIconTap,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with PreferredSizeWidget {
  String? _village;
  File? _profile_pic;

  @override
  void initState() {
    super.initState();
    initialiseDetails();
    _initProfilePic();
  }

  void _initProfilePic() async {
    File? file = await SharedService.getProfilePicture();
    if (file != null) {
      setState(() {
        _profile_pic = file;
      });
    }
  }

  Future<void> initialiseDetails() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    setState(() {
      _village = loginResponseModel?.village;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_village != null) {
      return AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            widget.imageUrl,
            // height: 60,
            // width: 60,
          ),
        ),
        title: Text(
          _village!,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Color(0xff21205b),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              // icon: Icon(Icons.person),
              // icon: ClipOval(
              //   child: Image.asset(
              //     'assets/images/user_profile_blue.png',
              //   ),
              // ),
              // icon: Container(
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: Colors.white,
              //       width: 1.5,
              //     ),
              //   ),
              //   child: _profile_pic != null
              //       ? CircleAvatar(
              //       radius: 56, backgroundImage: FileImage(_profile_pic!))
              //       : CircleAvatar(
              //     radius: 56,
              //     child: Image.asset('assets/images/user_profile_blue.png'),
              //   ),
              //
              // ),
              icon: Icon(Icons.menu, color: ColorConstants.darkBlueThemeColor,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      );
    }
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Image.asset(
          widget.imageUrl,
          // height: 60,
          // width: 60,
        ),
      ),
      title: Text(
        "wE-Panchayat",
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: Color(0xff21205b),
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            // icon: Icon(Icons.person),
            // icon: ClipOval(
            //   child: Image.asset(
            //     'assets/images/user_profile_blue.png',
            //   ),
            // ),
            // icon: Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: Colors.white,
            //       width: 1.5,
            //     ),
            //   ),
            //   child: CircleAvatar(
            //     radius: 56,
            //     child: Image.asset('assets/images/user_profile_blue.png'),
            //   ),
            // ),
            icon: Icon(Icons.menu, color: ColorConstants.darkBlueThemeColor,),
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

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    throw UnimplementedError();
  }

  @override
  // TODO: implement key
  Key? get key => throw UnimplementedError();

  @override
  String toStringDeep(
      {String prefixLineOne = '',
      String? prefixOtherLines,
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow(
      {String joiner = ', ',
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }
}
