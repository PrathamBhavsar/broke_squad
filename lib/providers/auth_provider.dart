import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_provider.dart';
import 'package:contri_buter/constants/routes.dart';
import 'package:contri_buter/models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool _isLoading = true;

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

  Future<void> signUpOrSignInUser(
      String email, String password, BuildContext context) async {
    toggleLoading();
    final auth = FirebaseAuth.instance;

    try {
      // Try to sign in the user
      UserCredential signInResponse = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User exists and is logged in
      print('User logged in: ${signInResponse.user!.email}');
      await _saveLoginState(signInResponse.user!.uid);
      Provider.of<NavigationProvider>(context, listen: false)
          .navigateToAndRemove(context, Routes.home);
      toggleLoading();
    } catch (error) {
      // If sign in fails, assume user does not exist and sign up
      try {
        UserCredential signUpResponse = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (signUpResponse.user != null) {
          // User created successfully
          await _saveLoginState(signUpResponse.user!.uid);

          await _createUserEntry(signUpResponse.user!, email);

          print('User signed up: ${signUpResponse.user!.email}');
          Provider.of<NavigationProvider>(context, listen: false)
              .navigateToAndRemove(context, Routes.info);
          toggleLoading();
        }
      } catch (signUpError) {
        // Handle sign-up error
        print('Sign-up failed: $signUpError');
        toggleLoading();
      }
    }
  }

  Future<void> _createUserEntry(User user, String email) async {
    final firestore = FirebaseFirestore.instance;

    // Create a new user object using the User model
    final newUser = UserModel(
      id: user.uid,
      email: email,
      userName: '',
      profileImage: '',
      createdAt: DateFormat('EEEE, MMM d, y').format(DateTime.now()),
    );

    // Insert the user into the Firestore users collection
    try {
      await firestore.collection('users').doc(user.uid).set(newUser.toJson());
      print('User created with ID: ${user.uid}');
    } catch (error) {
      // Handle error
      print('Insert user error: $error');
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

    Provider.of<NavigationProvider>(context, listen: false)
        .navigateToAndRemove(context, Routes.login);
    notifyListeners();
  }
}
