import 'package:flutter/material.dart';

class FormConstants {
  static TextStyle getTextStyle() {
    return TextStyle(
      color: ColorConstants.darkBlueThemeColor,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle getLabelAndHintStyle() {
    return TextStyle(
      color: ColorConstants.formLabelTextColor,
      fontFamily: 'Poppins-Medium',
    );
  }

  static OutlineInputBorder getEnabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: ColorConstants.formBorderColor,
        width: 2,
      ),
    );
  }

  static OutlineInputBorder getFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: ColorConstants.darkBlueThemeColor,
        width: 1,
      ),
    );
  }



  // DropDown

  static TextStyle getDropDownTextStyle() {
    return TextStyle(
      color: ColorConstants.darkBlueThemeColor,
      fontFamily: 'Poppins-Medium',
      fontSize: 14,
    );
  }

  static TextStyle getDropDownHintStyle() {
    return TextStyle(
      color: ColorConstants.formLabelTextColor,
      fontFamily: 'Poppins-Medium',
      fontSize: 14,
    );
  }

  static TextStyle getDropDownDisabledStyle() {
    return const TextStyle(
      color: Colors.grey,
      fontFamily: 'Poppins-Medium',
      fontSize: 14,
    );
  }

  static BoxDecoration getDropDownBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: ColorConstants.formBorderColor,
        width: 2,
      ),
      color: Colors.white,
    );
  }

  static Icon getDropDownIcon() {
    return Icon(
      Icons.arrow_drop_down_outlined,
      color: ColorConstants.formLabelTextColor,
    );
  }


  // Calender
  static Icon getCalenderIcon() {
    return Icon(
      Icons.calendar_month,
      color: ColorConstants.formLabelTextColor,
    );
  }
}

class ColorConstants {
  static final Color formLabelTextColor = Color(0xff7b7f9e);
  static final Color formBorderColor = Color(0xffDBDFEA);
  static final Color darkBlueThemeColor = Color(0xff21205b);
  static final Color submitGreenColor = Color(0xff6CC51D);
  static final Color lightBlueThemeColor = Color(0xFF5386E4);
  static final Color grievanceYellowColor = Color(0xFFFFD95A);
  static final Color grievanceRedColor = Color(0xFFE06469);

}

class AlertDialogBoxConstants {
  static TextStyle getTitleTextStyle() {
    return TextStyle(
      color: ColorConstants.darkBlueThemeColor,
      fontFamily: 'Poppins-Bold',
    );
  }

  static TextStyle getContentTextStyle() {
    return TextStyle(
      color: ColorConstants.formLabelTextColor,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle getButtonTextStyle() {
    return TextStyle(
      color: ColorConstants.lightBlueThemeColor,
      fontFamily: 'Poppins-Bold',
    );
  }

  static TextStyle getNormalTextStyle() {
    return TextStyle(
      color: ColorConstants.darkBlueThemeColor,
      fontFamily: 'Poppins-Medium',
    );
  }
}
