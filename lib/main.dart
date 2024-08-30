import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:contri_buter/providers/user_provider.dart'; // Import the HomeProvider
import 'package:contri_buter/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isCheckingLoginState = true;
  String initialRoute = Routes.login; // Default to login route

  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  Future<void> checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(
        Duration(seconds: 2)); // Optional: Simulate loading time

    setState(() {
      initialRoute = isLoggedIn ? Routes.home : Routes.login;
      isCheckingLoginState = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        // navigatorKey: GlobalKey<NavigatorState>(), // Ensure Navigator context
        // onGenerateRoute: Routes.generateRoute,
        // home: isCheckingLoginState ? SplashScreen() : _buildHomeScreen(),
        routerConfig: MyRouter.router);
  }

  Widget _buildHomeScreen() {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<NavigationProvider>(context, listen: false)
              .navigateToAndRemove(context, initialRoute);
        });
        return Container();
      },
    );
  }
}
