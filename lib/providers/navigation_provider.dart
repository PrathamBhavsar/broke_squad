import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void navigateToAndRemove(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
