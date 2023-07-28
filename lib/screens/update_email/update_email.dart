import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_panchayat_dev/screens/profile/user_profile.dart';
import 'package:we_panchayat_dev/screens/security/mpin_create.dart';
import 'package:we_panchayat_dev/screens/security/mpin_disable.dart';

import '../../constants.dart';
import '../../models/login_response_model.dart';
import '../../services/auth_api_service.dart';
import '../../services/shared_service.dart';
import '../../services/update_email_api_service.dart';
import '../dialog_boxes.dart';

class UpdateEmailPage extends StatefulWidget {
  @override
  _UpdateEmailPageState createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  TextEditingController? _currentEmailController;
  TextEditingController _newEmailController = TextEditingController();

  int? _id;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initialiseDetails();
  }

  Future<void> initialiseDetails() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    setState(() {
      _currentEmailController =
          TextEditingController(text: loginResponseModel?.email);
      _id = loginResponseModel?.id;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
            child: const Text(
              'Update Email',
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
              'Update your Email address for communication',
              style: TextStyle(
                fontFamily: 'Poppins-Light',
                fontSize: 14,
                color: Color(0xff2B2730),
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _currentEmailController,
                      enabled: false,
                      style: FormConstants.getDisabledTextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Current Email',
                        labelStyle: FormConstants.getLabelAndHintStyle(),
                        // filled: true,
                        // fillColor: Colors.white,
                        border: FormConstants.getEnabledBorderAlternative(),
                        enabledBorder:
                            FormConstants.getEnabledBorderAlternative(),
                        disabledBorder:
                            FormConstants.getEnabledBorderAlternative(),
                        focusedBorder:
                            FormConstants.getFocusedBorderAlternative(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _newEmailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Invalid email";
                        } else if (_newEmailController.text ==
                            _currentEmailController?.text) {
                          return "Email cannot be same.";
                        }
                        return null;
                      },
                      style: FormConstants.getTextStyle(),
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'New Email',
                        labelStyle: FormConstants.getLabelAndHintStyle(),
                        // filled: true,
                        // fillColor: Colors.white,
                        border: FormConstants.getEnabledBorderAlternative(),
                        enabledBorder:
                            FormConstants.getEnabledBorderAlternative(),
                        focusedBorder:
                            FormConstants.getFocusedBorderAlternative(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> body = {
                      "newEmail": _newEmailController.text,
                      "applicationId": "$_id",
                    };

                    var response =
                        await UpdateEmailAPIService.updateEmail(body);


                    if(response != null) {
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Email updated')));
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile()),
                        );
                      } else if(response.statusCode == 500) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Email already exists.')));
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error updating email')));
                      }
                    } else {
                      DialogBoxes.showServerDownDialogBox(context);
                    }


                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
                style: AuthConstants.getSubmitButtonStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
