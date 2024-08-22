import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 30,
            width: 50,
            color: Ui.accentColor,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20)),
          )
        ],
      ),
    );
  }
}
