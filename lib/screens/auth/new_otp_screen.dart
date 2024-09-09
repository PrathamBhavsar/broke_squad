import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OptInputScreen extends StatefulWidget {
  final int phoneNumber;

  const OptInputScreen({super.key, required this.phoneNumber});

  @override
  State<OptInputScreen> createState() => _OptInputScreenState();
}

class _OptInputScreenState extends State<OptInputScreen> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: AppPaddings.getBottomPadding(context),
        child: Center(
          child: SingleChildScrollView(
            reverse: false,
            child: Padding(
              padding: AppPaddings.scaffoldPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Verify your\nPhone Number",
                    style: AppTextStyles.kOnboardingTitleTextStyle
                        .copyWith(color: AppColors.kDarkColor),
                    textAlign: TextAlign.center,
                  ),
                  Text("Enter your OTP code here.",
                      style: AppTextStyles.kOnboardingSubtitleTextStyle,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.kAuthTextFieldColor,
                            shape: BoxShape.circle,
                          ),
                          textStyle:
                              AppTextStyles.kPhoneInputTextFieldTextStyle),
                      submittedPinTheme: PinTheme(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        textStyle: AppTextStyles.kPhoneInputTextFieldTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      onChanged: (value) {
                        otp = value;
                        if (value.length == 6) {
                          //TODO: Run method to verify otp here
                          authProvider.verifyOtp(
                            otp,
                            context,
                            widget.phoneNumber,
                          );
                        }
                      },
                      onSubmitted: (value) {
                        //TODO: Run method to verify otp here too
                        // Verify OTP
                        authProvider.verifyOtp(
                          otp,
                          context,
                          widget.phoneNumber,
                        );
                        logEvent(str: 'VALUE : $value');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Didn't receive any code?",
                      style: AppTextStyles.kOnboardingSubtitleTextStyle,
                      textAlign: TextAlign.center),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "RESEND CODE",
                        style: AppTextStyles.poppins.copyWith(
                          letterSpacing: 1.5,
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
