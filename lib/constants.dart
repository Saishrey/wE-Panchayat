import 'package:flutter/material.dart';

class FormConstants {
  static TextStyle getTextStyle() {
    return TextStyle(
      color: ColorConstants.darkBlueThemeColor,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle getDisabledTextStyle() {
    return TextStyle(
      color: ColorConstants.lightBlackColor,
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

  // Alternatives

  static UnderlineInputBorder getEnabledBorderAlternative() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    );
  }

  static UnderlineInputBorder getFocusedBorderAlternative() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
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

  // Alternatives
  static final Color formLabelTextColorAlternative = Color(0xff5F5F5F);
  static final Color formBorderColorAlternative = Color(0xff9C9C9C);


  static final Color darkBlueThemeColor = Color(0xff21205b);
  static final Color submitGreenColor = Color(0xff6CC51D);
  static final Color lightBlueThemeColor = Color(0xFF5386E4);
  static final Color grievanceYellowColor = Color(0xFFFFD95A);
  static final Color grievanceRedColor = Color(0xFFE06469);
  static final Color backgroundClipperColor = Color(0xffDDF0FF);
  static final Color lightBlackColor =  Color(0xff2B2730);

  // Sky Blue Color Palette
  static final Color colorHuntCode1 = Color(0xFFAEE1FC);
  static final Color colorHuntCode2 = Color(0xFF60ABFB);
  static final Color colorHuntCode3 = Color(0xFF5170FD);
  static final Color colorHuntCode4 = Color(0xFF4636FC);
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


class AuthConstants {
  static TextStyle getTextStyle() {
    return TextStyle(
      color: ColorConstants.darkBlueThemeColor,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle getLabelAndHintStyle() {
    return TextStyle(
      color: ColorConstants.formLabelTextColor,
      // color: ColorConstants.lightBlueThemeColor,
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



  static ButtonStyle getSubmitButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          ColorConstants.lightBlueThemeColor),
      shape: MaterialStateProperty.all<
          RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.only(top: 15.0, bottom: 15.0),
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
