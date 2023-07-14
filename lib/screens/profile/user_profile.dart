import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import '../background_painter.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? _fullname;
  String? _dob;
  String? _gender = "Male";
  String? _taluka;
  String? _village;
  String? _address;
  String? _pincode;
  String? _phone;
  String? _email;

  @override
  void initState() {
    super.initState();
    initialiseNamePhoneAddress();
  }

  Future<void> initialiseNamePhoneAddress() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    setState(() {
      _fullname = loginResponseModel?.fullname;
      _dob = formatDate(loginResponseModel?.dateofbirth);
      _taluka = loginResponseModel?.taluka;
      _village = loginResponseModel?.village;
      _address = loginResponseModel?.address;
      _pincode = loginResponseModel?.pincode;
      _phone = loginResponseModel?.phone;
      _email = loginResponseModel?.email;
    });
  }

  String formatDate(String? dateStr) {
    DateTime date = DateTime.parse(dateStr!);
    return DateFormat('MMMM dd yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if(_fullname == null || _dob == null || _taluka == null || _village == null || _address == null || _pincode == null || _phone == null || _email == null) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorConstants.backgroundClipperColor,
          foregroundColor: Color(0xff415EB6),
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
              )
            ),
          ],
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundClipperColor,
        foregroundColor: Color(0xff415EB6),
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
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.blue,
                            child: Image.asset(
                                'assets/images/user_profile_blue.png'),
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
                  "Shreyas Prasad Naik",
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
                          color: Colors.grey.withOpacity(0.75),
                          spreadRadius: 0.5,
                          blurRadius: 0.75,
                          offset: Offset(
                              0, 2.5), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        _buildSection('Phone', _phone!, true),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('Email', _email!, true),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('DOB', _dob!, false),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('Gender', _gender!, false),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('Taluka', _taluka!, false),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('Village', _village!, false),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('Address', _address!, false),
                        const Divider(
                          thickness: 1,
                        ),
                        _buildSection('Pincode', _pincode!, false),
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

Widget _buildSection(String title, String text, bool isEditable) {
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
                  fontSize: 16,
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
                fontSize: 16,
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
                onTap: () {
                  // Add your desired logic or function here
                  // This function will be called when the icon button is pressed
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



