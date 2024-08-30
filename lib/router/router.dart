import 'package:contri_buter/screens/add_costs/add_costs_screen.dart';
import 'package:contri_buter/screens/auth/login_screen.dart';
import 'package:contri_buter/screens/home_screen/home_screen.dart';
import 'package:contri_buter/screens/onboarding/onboarding_screen.dart';
import 'package:contri_buter/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class MyRouter {
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      name: 'root',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/add_costs',
      name: 'add_costs',
      builder: (context, state) => AddCostsScreen(),
    )
  ]);
}
