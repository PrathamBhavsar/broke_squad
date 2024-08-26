import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants/routes.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://soewklntzggifhxxmlix.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNvZXdrbG50emdnaWZoeHhtbGl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ2NDg3MzUsImV4cCI6MjA0MDIyNDczNX0.gufJtM0ZO2PjS-ykGxddHUc5U_lAaBWDjR1cjXIjYWU');
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MyApp(),
    ),
  );
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
