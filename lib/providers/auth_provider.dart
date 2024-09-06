import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/screens/auth/new_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'package:contri_buter/models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool _isLoading = false;
  String? _verificationId;

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

  Future<void> requestOtp(int phoneNumber, BuildContext context) async {
    toggleLoading();
    final auth = FirebaseAuth.instance;
    final fullPhoneNumber = '+$phoneNumber';

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithPhoneAuthCredential(credential, context, phoneNumber, autoSignIn: true);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
          toggleLoading();
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          print('OTP sent to $fullPhoneNumber');

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OptInputScreen(phoneNumber: phoneNumber),
          ));

          toggleLoading();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (error) {
      print('Failed to request OTP: $error');
      toggleLoading();
    }
  }

  Future<void> verifyOtp(String otp, BuildContext context, int phoneNumber) async {
    toggleLoading();

    try {
      if (_verificationId != null) {
        final phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: otp,
        );

        await _signInWithPhoneAuthCredential(phoneAuthCredential, context, phoneNumber,
            autoSignIn: false);
      } else {
        print('Verification ID is null. Cannot verify OTP.');
        toggleLoading();
      }
    } catch (e) {
      print('Failed to verify OTP: $e');
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The OTP you entered is incorrect. Please try again.'),
          ),
        );
      }
      toggleLoading();
    }
  }

  Future<void> _signInWithPhoneAuthCredential(
      PhoneAuthCredential credential, BuildContext context, int phoneNumber,
      {required bool autoSignIn}) async {
    final auth = FirebaseAuth.instance;

    try {
      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        await _createUserEntry(userCredential.user!, phoneNumber);
        context.goNamed('info');
      } else {
        print('User logged in: ${userCredential.user!.phoneNumber}');

        context.goNamed('home');
      }

      await _saveLoginState(userCredential.user!.uid);
      toggleLoading();
    } catch (error) {
      print('Failed to sign in with PhoneAuthCredential: $error');
      if (error is FirebaseAuthException && error.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The OTP you entered is incorrect. Please try again.'),
          ),
        );
      }
      toggleLoading();
    }
  }

  Future<void> _createUserEntry(User user, int phoneNumber) async {
    final firestore = FirebaseFirestore.instance;
    final newUser = UserModel(
      id: user.uid,
      phoneNumber: '+$phoneNumber',
      userName: '',
      profileImage: '',
      createdAt: DateFormat('EEEE, MMM d, y').format(DateTime.now()),
    );

    try {
      await firestore.collection('users').doc('+$phoneNumber').set(newUser.toJson());
      print('User created with ID: ${user.uid}');
    } catch (error) {
      print('Failed to create user entry: $error');
    }
  }

  Future<void> _saveLoginState(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', userId);
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
    await FirebaseAuth.instance.signOut();

    context.goNamed('login');

    notifyListeners();
  }
}
