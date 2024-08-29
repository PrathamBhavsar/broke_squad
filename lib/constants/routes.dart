import 'package:contri_buter/screens/add_costs/add_costs_screen.dart';
import 'package:contri_buter/screens/auth/login_screen.dart';
import 'package:contri_buter/screens/home_screen/home_screen.dart';
import 'package:contri_buter/screens/info/info_screen.dart';
import 'package:contri_buter/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String info = '/info';
  static const String addCosts = '/add_costs';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case info:
        return MaterialPageRoute(builder: (_) => InfoScreen());
      case addCosts:
        return MaterialPageRoute(builder: (_) => AddCostsScreen());
      // Add other routes here
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
