import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode phoneFocusNode = FocusNode();
  // final TextEditingController phoneController = TextEditingController();
  final TextEditingController areaCodeController =
      TextEditingController(text: "+91"); // Default area code
  PhoneNumber phoneNumber = PhoneNumber();

  @override
  void dispose() {
    // Clean up the controllers and focus nodes when the widget is disposed
    phoneFocusNode.dispose();
    // phoneController.dispose();
    areaCodeController.dispose();
    super.dispose();
  }

  _manageLogin() async {
    String? phNo = phoneNumber.phoneNumber;
    String? code = phoneNumber.dialCode;
    if (phNo == null || code == null) {
      return;
    } else if (phNo.length < 10 || code.isEmpty) {
      return;
    } else {
      logEvent(str: '$phNo');

      // if (authProvider.isLoading) return;
      //
      // // Request OTP using the phone number provided
      // await authProvider.requestOtp(
      //   '+91',
      //   int.parse(phoneController.text),
      //   context,
      // );

      // If the OTP is sent, show a dialog to enter the OTP
      // if (!authProvider.isLoading) {
      //   _showOtpDialog(context, authProvider);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss the keyboard when tapping outside
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: SingleChildScrollView(
              child: SizedBox(
                height: getHeight(context) - kBottomNavigationBarHeight,
                child: Padding(
                  padding:AppPaddings.scaffoldPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/login.png',
                        height: getHeight(context) * 0.4,
                      ),
                      Text(
                        "Log In and Make Splitting Easy!",
                        style: AppTextStyles.kOnboardingTitleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          "Get started—track, share, and settle your expenses in just a few taps.",
                          style: AppTextStyles.kOnboardingSubtitleTextStyle,
                          textAlign: TextAlign.center),
                      SizedBox(height: 30),
                      _buildPhoneInputField(),
                      const Spacer(),
                      _buildSubmitButton(),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  _buildPhoneInputField() {
    return InternationalPhoneNumberInput(
        initialValue: PhoneNumber(isoCode: 'IN', phoneNumber: ''),
        ignoreBlank: false,
        maxLength: 10,
        focusNode: phoneFocusNode,
        selectorTextStyle: AppTextStyles.kPhoneInputTextFieldTextStyle,
        textStyle: AppTextStyles.kPhoneInputTextFieldTextStyle,
        inputDecoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none),
          fillColor: Color.fromRGBO(235, 240, 245, 1),
          filled: true,
        ),
        formatInput: true,
        countrySelectorScrollControlled: true,
        selectorConfig: SelectorConfig(
            showFlags: true,
            trailingSpace: false,
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            leadingPadding: 12.0,
            useBottomSheetSafeArea: true,
            setSelectorButtonAsPrefixIcon: true),
        onInputChanged: (value) => phoneNumber = value,
      );
  }
  _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _manageLogin,
      child: Text(
        'SEND OTP',
        style: AppTextStyles.poppins.copyWith(
          letterSpacing: 1.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
        backgroundColor:
        WidgetStatePropertyAll(AppColors.kPrimaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
