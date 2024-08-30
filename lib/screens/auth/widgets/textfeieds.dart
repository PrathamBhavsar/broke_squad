import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneTextField extends StatelessWidget {
  PhoneTextField(
      {super.key, required this.phoneFocusNode, required this.phoneController});

  final FocusNode phoneFocusNode;
  final TextEditingController phoneController;

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
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.primaryColor,
            focusNode: phoneFocusNode,
            controller: phoneController,
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
                labelText: 'Phone',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}
