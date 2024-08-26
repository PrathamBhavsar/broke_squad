import 'package:contri_buter/constants/UI.dart';

import 'package:flutter/material.dart';

class passwordTextField extends StatelessWidget {
   passwordTextField({super.key, required this.passwordFocusNode, required this.passwordController});

  final FocusNode passwordFocusNode;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadiusDirectional.circular(10)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            cursorColor: AppColors.primaryColor,
            focusNode: passwordFocusNode,
            decoration: InputDecoration(
                focusColor: AppColors.primaryColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 2)),
                labelText: 'Password',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}

class emailTextField extends StatelessWidget {
  emailTextField(
      {super.key, required this.emailFocusNode, required this.emailController});

  final FocusNode emailFocusNode;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadiusDirectional.circular(10)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppColors.primaryColor,
            focusNode: emailFocusNode,
            decoration: InputDecoration(
                focusColor: AppColors.primaryColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 2)),
                labelText: 'Email',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}
