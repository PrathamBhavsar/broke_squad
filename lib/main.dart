import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/providers/split_provider.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.instance),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SplitProvider.instance),
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        // navigatorKey: GlobalKey<NavigatorState>(), // Ensure Navigator context
        // onGenerateRoute: Routes.generateRoute,
        // home: isCheckingLoginState ? SplashScreen() : _buildHomeScreen(),
        routerConfig: MyRouter.router);
  }
}
