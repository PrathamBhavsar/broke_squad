import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController areaCodeController;
  final TextEditingController otpController =
      TextEditingController(); // Controller for OTP input

  LoginButton({
    super.key,
    required this.phoneController,
    required this.areaCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return GestureDetector(
          onTap: () async {
            if (authProvider.isLoading) return;

            // Request OTP using the phone number provided
            await authProvider.requestOtp(
              '+91',
              int.parse(phoneController.text),
              context,
            );

            // If the OTP is sent, show a dialog to enter the OTP
            if (!authProvider.isLoading) {
              _showOtpDialog(context, authProvider);
            }
          },
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: authProvider.isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  // Function to show the OTP input dialog
  void _showOtpDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog without entering OTP
      builder: (context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(hintText: 'Enter the OTP sent to your phone'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (otpController.text.isNotEmpty) {
                  // Verify OTP
                  await authProvider.verifyOtp(
                    otpController.text,
                    context,
                    '+91', // Example area code; make sure it matches the request
                    int.parse(phoneController.text),
                  );

                  Navigator.of(context).pop(); // Close the OTP dialog
                }
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }
}
