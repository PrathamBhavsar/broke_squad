import 'package:contri_buter/controllers/revcat.dart';
import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/providers/split_provider.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/router/router.dart';
import 'package:contri_buter/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //TODO: After Getting API Key Uncomment this!
  await RevCat.initSDK();
  await MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.instance),
        ChangeNotifierProvider(create: (context) => AuthProvider.instance),
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
