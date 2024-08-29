import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  // Navigate to a new route and push it onto the navigation stack
  void navigateTo(BuildContext context, String routeName) {
    // Ensure the context is ready by using a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.canPop(context)) {
        Navigator.pushNamed(context, routeName);
      }
    });
  }

  // Navigate to a new route and remove all previous routes from the stack
  void navigateToAndRemove(BuildContext context, String routeName) {
    // Ensure the context is ready by using a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
    });
  }

  // Pop the current route off the navigation stack
  void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
