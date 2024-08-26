import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => NavigationProvider(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.onboarding,
    );
  }
}
