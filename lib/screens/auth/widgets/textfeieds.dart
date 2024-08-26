import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.passwordFocusNode,
    required this.passwordController,
  });

  final FocusNode passwordFocusNode;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AuthProvider>(
            builder: (context, loginProvider, child) {
              return TextField(
                keyboardType: TextInputType.visiblePassword,
                cursorColor: AppColors.primaryColor,
                focusNode: passwordFocusNode,
                obscureText: !loginProvider.isVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginProvider.toggleVisibility();
                    },
                    child: Icon(
                      loginProvider.isVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                  suffixIconColor: AppColors.primaryColor,
                  focusColor: AppColors.primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField(
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
            controller: emailController,
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
