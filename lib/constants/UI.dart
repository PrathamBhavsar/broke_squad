import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color primaryColor = Color(0xFF1F2128);
  static Color secondaryColor = Color(0xFFDFF169);
  static Color accentColor = Color(0xFFAEBDC2);
  static Color lightGrey = Color(0xFFF5F5F5);
  static Color white = Color(0xFFFFFFFF);
  static Color kPrimaryColor = Color(0xFFE14150);
  static Color kDarkColor = Color(0xFF000000);
  static Color kAuthTextFieldColor = Color.fromRGBO(235, 240, 245, 1);
}

class AppPaddings {
  static EdgeInsetsGeometry scaffoldPadding =  EdgeInsets.fromLTRB(12, 12, 12, 12);

  static EdgeInsetsGeometry getBottomPadding(context) => EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom);

  // static EdgeInsetsGeometry scaffoldPadding = EdgeInsets.fromLTRB(left, top, right, bottom)
}

class AppTextStyles{
  static TextStyle poppins = GoogleFonts.poppins();
  static TextStyle kOnboardingTitleTextStyle = GoogleFonts.poppins(
    color: AppColors.kPrimaryColor,
    fontSize: 22.0.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kOnboardingSubtitleTextStyle = GoogleFonts.poppins(
    color: Colors.black38,
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kPhoneInputTextFieldTextStyle = GoogleFonts.poppins(
    color: AppColors.kDarkColor,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
}