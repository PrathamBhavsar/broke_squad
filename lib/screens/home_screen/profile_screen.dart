import 'package:contri_buter/controllers/revcat.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goNamed('home');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Profile Screen'),
            TextButton(
                onPressed: () async {
                  PaywallResult result =
                      await RevenueCatUI.presentPaywall(displayCloseButton: true);
                  if (result == PaywallResult.purchased)
                    await RevCat.onSuccess();
                  else if (result == PaywallResult.error)
                    RevCat.onError();
                  else if (result == PaywallResult.cancelled)
                    RevCat.onFailure();
                  else
                    logEvent(str: 'result: ${result.name}');
                },
                child: Text('Get Pro'))
          ],
        ),
      ),
    );
  }
}