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
  static Color grey = Color(0xFF9B9B9B);
}

class AppPaddings {
  static EdgeInsetsGeometry scaffoldPadding =
      EdgeInsets.fromLTRB(12, 12, 12, 12);

  static EdgeInsetsGeometry getBottomPadding(context) =>
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom);

  // static EdgeInsetsGeometry scaffoldPadding = EdgeInsets.fromLTRB(left, top, right, bottom)
}

class AppTextStyles {
  static TextStyle poppins = GoogleFonts.poppins();
  static TextStyle kOnboardingTitleTextStyle = GoogleFonts.poppins(
    color: AppColors.kPrimaryColor,
    fontSize: 22.0.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kOnboardingSubtitleTextStyle = poppins.copyWith(
    color: Colors.black38,
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kTransactionTitleTextStyle =poppins.copyWith(
    color: AppColors.kDarkColor,
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle kTransactionSubtitleTextStyle = poppins.copyWith(
    color: AppColors.kDarkColor,
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle kPhoneInputTextFieldTextStyle = poppins.copyWith(
    color: AppColors.kDarkColor,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  static TextStyle kCreateBillAppBarTitleTextStyle = poppins.copyWith(
    color: AppColors.kDarkColor,fontWeight: FontWeight.bold,letterSpacing: 1.2,fontSize: 16.sp,
  );
  static TextStyle kCreateBillTextFieldTextStyle = poppins.copyWith(
      color: AppColors.grey,
      fontWeight: FontWeight.w600,
      fontSize: 13.sp
  );
}
