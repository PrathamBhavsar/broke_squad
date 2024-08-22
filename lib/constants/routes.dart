import 'package:contri_buter/screens/login_screen.dart';
import 'package:contri_buter/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/second';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // Add other routes here
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
