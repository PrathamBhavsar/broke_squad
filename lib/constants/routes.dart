import 'package:contri_buter/screens/auth/login_screen.dart';
import 'package:contri_buter/screens/home_screen.dart';
import 'package:contri_buter/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // Add other routes here
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
