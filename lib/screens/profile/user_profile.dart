import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_panchayat_dev/models/profile_picture_retrieve.dart';
import 'package:we_panchayat_dev/screens/profile/profile_pic.dart';
import 'package:we_panchayat_dev/services/update_email_api_service.dart';

import '../../constants.dart';
import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import '../background_painter.dart';
import '../update_email/verify_user.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int? _id;
  String? _fullname;
  String? _dob;
  String? _gender;
  String? _taluka;
  String? _village;
  String? _address;
  String? _pincode;
  String? _phone;
  String? _email;
  String? _mongoId;

  final Map<String, String> _genderMap = {
    'M': 'Male',
    'F': 'Female',
    'O': 'Other',
  };

  String? _tempPath;

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
      _id = loginResponseModel?.id;
      _fullname = loginResponseModel?.fullname;
      _dob = formatDate(loginResponseModel?.dateofbirth);
      _taluka = loginResponseModel?.taluka;
      _village = loginResponseModel?.village;
      _address = loginResponseModel?.address;
      _pincode = loginResponseModel?.pincode;
      _phone = loginResponseModel?.phone;
      _gender = loginResponseModel?.gender;
      _email = loginResponseModel?.email;
      _mongoId = loginResponseModel?.mongoId;
    });
  }

  String formatDate(String? dateStr) {
    DateTime date = DateTime.parse(dateStr!);
    return DateFormat('MMMM dd yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (_fullname == null ||
        _dob == null ||
        _taluka == null ||
        _village == null ||
        _address == null ||
        _pincode == null ||
        _phone == null ||
        _email == null) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorConstants.backgroundClipperColor,
          foregroundColor: ColorConstants.darkBlueThemeColor,
          title: Text(
            'My Profile',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 18,
            ),
          ),
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: HeaderDelegate(
                minHeight: 200, // Set the minimum height of the header
                maxHeight: 280, // Set the maximum height of the header
                child: CustomPaint(
                  painter: BackgroundPainter(),
                  child: Container(),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Center(
              child: CircularProgressIndicator(
                color: ColorConstants.lightBlueThemeColor,
                strokeWidth: 6,
              ),
            )),
          ],
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundClipperColor,
        foregroundColor: ColorConstants.lightBlackColor,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              minHeight: 200, // Set the minimum height of the header
              maxHeight: 280, // Set the maximum height of the header
              child: CustomPaint(
                painter: BackgroundPainter(),
                child: Container(
                  child: Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Tapped on Profile Picture.");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePicturePage(userId: _id!, mongoId: _mongoId ?? "NA", isSignup: false)),
                            );
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                            ),
                            child: _profile_pic != null
                                ? CircleAvatar(
                                    radius: 56,
                                    backgroundImage: FileImage(_profile_pic!))
                                : CircleAvatar(
                                    radius: 56,
                                    child: Image.asset(
                                        'assets/images/user_profile_blue.png'),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  _fullname!,
                  style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(
                              0, 2), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        _buildSection(context, 'Email', _email!, true),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'Phone', _phone!, false),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'DOB', _dob!, false),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'Gender', _genderMap[_gender!]!, false),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'Taluka', _taluka!, false),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'Village', _village!, false),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'Address', _address!, false),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        _buildSection(context, 'Pincode', _pincode!, false),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSection(BuildContext context, String title, String text, bool isEditable) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins-Light',
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Visibility(
          visible: isEditable,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                onTap: () async {

                  if(title == "Email") {
                    bool response = await UpdateEmailAPIService.getOtpUpdateEmail();

                    if(response) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyUserUpdateEmail()),
                      );
                    }
                    else {
                      print('Error sending otp.');
                    }
                  }
                },
                child: Ink(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: ColorConstants.formLabelTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
