import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';

class loginButton extends StatelessWidget {
  const loginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return                         Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius:
          BorderRadiusDirectional.circular(10)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Log in',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
