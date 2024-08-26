import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginButton extends StatelessWidget {
  const loginButton({super.key, required this.email, required this.password});

final String email;
final String password;


  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return GestureDetector(
          onTap: () {
            loginProvider.signUpOrSignInUser(email, password);
          },
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Log in',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
