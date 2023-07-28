import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import '../services/shared_service.dart';
import 'auth/login.dart';

class DialogBoxes {
  static showConnectivityDialogBox(BuildContext context)  => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'No Internet Connection',
        style: AlertDialogBoxConstants.getTitleTextStyle(),
      ),
      content: Text(
        'Please check your internet connection and try again.',
        style: AlertDialogBoxConstants.getContentTextStyle(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            SystemNavigator.pop();
          },
          child: Text(
            'OK',
            style: AlertDialogBoxConstants.getButtonTextStyle(),
          ),
        ),
      ],
    ),
  );

  static showServerDownDialogBox(BuildContext context)  => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'Server Error',
        style: AlertDialogBoxConstants.getTitleTextStyle(),
      ),
      content: Text(
        'Web server is down. Please try again later',
        style: AlertDialogBoxConstants.getContentTextStyle(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            SystemNavigator.pop();
          },
          child: Text(
            'OK',
            style: AlertDialogBoxConstants.getButtonTextStyle(),
          ),
        ),
      ],
    ),
  );

  static showSessionExpiryDialogBox(BuildContext context) => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'Session Expired',
        style: AlertDialogBoxConstants.getTitleTextStyle(),
      ),
      content: Text(
        'Please log in again.',
        style: AlertDialogBoxConstants.getContentTextStyle(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            SharedService.logout(context);
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          child: Text(
            'OK',
            style: AlertDialogBoxConstants.getButtonTextStyle(),
          ),
        ),
      ],
    ),
  );

}