import 'package:contri_buter/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'navigation_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  Future<void> signUpOrSignInUser(String email, String password, BuildContext context) async {
    final supabase = Supabase.instance.client;

    try {
      // Try to sign in the user
      final signInResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (signInResponse.user != null) {
        // User exists and is logged in
        print('User logged in: ${signInResponse.user!.email}');
        Provider.of<NavigationProvider>(context, listen: false)
            .navigateToAndRemove(context, Routes.home);
      }
    } catch (error) {
      // If sign in fails, assume user does not exist and sign up
      try {
        final signUpResponse = await supabase.auth.signUp(
          email: email,
          password: password,
        );

        if (signUpResponse.user != null) {
          // User created successfully
          print('User signed up: ${signUpResponse.user!.email}');
          Provider.of<NavigationProvider>(context, listen: false)
              .navigateToAndRemove(context, Routes.home);
        }
      } catch (signUpError) {
        // Handle sign-up error
        print('Sign-up failed: $signUpError');
      }
    }
  }

  Future<void> createUser() async {

  }
}
