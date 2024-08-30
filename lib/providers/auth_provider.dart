import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/screens/auth/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'navigation_provider.dart';
import 'package:contri_buter/constants/routes.dart';
import 'package:contri_buter/models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool _isLoading = false;
  String? _verificationId; // To store the verification ID after sending OTP

  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> requestOtp(
      String areaCode, int phoneNumber, BuildContext context) async {
    toggleLoading();
    final auth = FirebaseAuth.instance;
    final fullPhoneNumber = '$areaCode$phoneNumber';

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback is called when the verification is completed automatically
          await _signInWithPhoneAuthCredential(
              credential, context, areaCode, phoneNumber);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle error
          print('Verification failed: ${e.message}');
          toggleLoading();
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store the verification ID to be used later for OTP verification
          _verificationId = verificationId;
          print('OTP sent to $fullPhoneNumber');

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpScreen(phoneNumber: phoneNumber),
          ));

          toggleLoading();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out
          _verificationId = verificationId;
        },
      );
    } catch (error) {
      print('Failed to request OTP: $error');
      toggleLoading();
    }
  }

  // Function to verify OTP entered by the user
  Future<void> verifyOtp(String otp, BuildContext context, String areaCode,
      int phoneNumber) async {
    toggleLoading();
    final auth = FirebaseAuth.instance;

    try {
      if (_verificationId != null) {
        // Create a PhoneAuthCredential with the OTP and verification ID
        final phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: otp,
        );

        // Sign in or sign up the user with the provided credentials
        await _signInWithPhoneAuthCredential(
            phoneAuthCredential, context, areaCode, phoneNumber);
      } else {
        print('Verification ID is null. Cannot verify OTP.');
        toggleLoading();
      }
    } catch (error) {
      print('Failed to verify OTP: $error');
      toggleLoading();
    }
  }

  // Helper function to sign in with PhoneAuthCredential and create user entry if new
  Future<void> _signInWithPhoneAuthCredential(PhoneAuthCredential credential,
      BuildContext context, String areaCode, int phoneNumber) async {
    final auth = FirebaseAuth.instance;

    try {
      // Sign in the user with the given credential
      final userCredential = await auth.signInWithCredential(credential);

      // Check if the user is new or existing
      if (userCredential.additionalUserInfo!.isNewUser) {
        // User signed up
        await _createUserEntry(userCredential.user!, areaCode, phoneNumber);
        Provider.of<NavigationProvider>(context, listen: false)
            .navigateToAndRemove(context, Routes.info);
      } else {
        // User logged in
        print('User logged in: ${userCredential.user!.phoneNumber}');
        Provider.of<NavigationProvider>(context, listen: false)
            .navigateToAndRemove(context, Routes.home);
      }

      await _saveLoginState(userCredential.user!.uid);
      toggleLoading();
    } catch (error) {
      print('Failed to sign in with PhoneAuthCredential: $error');
      toggleLoading();
    }
  }

  // Function to create a new user entry in Firestore
  Future<void> _createUserEntry(
      User user, String areaCode, int phoneNumber) async {
    final firestore = FirebaseFirestore.instance;
    final newUser = UserModel(
      id: user.uid,
      phoneNumber: '$areaCode$phoneNumber',
      userName: '',
      profileImage: '',
      createdAt: DateFormat('EEEE, MMM d, y').format(DateTime.now()),
    );

    try {
      await firestore.collection('users').doc(user.uid).set(newUser.toJson());
      print('User created with ID: ${user.uid}');
    } catch (error) {
      print('Failed to create user entry: $error');
    }
  }

  // Function to save the login state in SharedPreferences
  Future<void> _saveLoginState(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', userId);
  }

  // Function to handle logout
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
    await FirebaseAuth.instance.signOut();

    Provider.of<NavigationProvider>(context, listen: false)
        .navigateToAndRemove(context, Routes.login);
    notifyListeners();
  }
}
