import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  final dynamic phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _showOtpDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                    widget.phoneNumber, // Replace with the actual phone number
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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enter OTP'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please enter the OTP sent to your phone number.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (authProvider.isLoading) return;

                  // Verify OTP
                  await authProvider.verifyOtp(
                    otpController.text,
                    context,
                    '+91', // Example area code; ensure it matches the request
                    widget.phoneNumber, // Replace with the actual phone number
                  );

                  // Navigate to the appropriate screen based on the result
                  if (!authProvider.isLoading) {
                    context.goNamed('home');
                  }
                },
                child: authProvider.isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Verify'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => _showOtpDialog(context, authProvider),
                child: Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
