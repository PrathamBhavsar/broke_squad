import 'package:contri_buter/constants/UI.dart';

import 'package:flutter/material.dart';


class NameTextField extends StatelessWidget {
  NameTextField(
      {super.key, required this.nameFocusNode, required this.nameController});

  final FocusNode nameFocusNode;
  final TextEditingController nameController;

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
          padding: const EdgeInsets.all(14.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppColors.primaryColor,
            focusNode: nameFocusNode,
            controller: nameController,
            decoration: InputDecoration(
                focusColor: AppColors.primaryColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        style: BorderStyle.none,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        style: BorderStyle.none,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 2)),
                labelText: 'Name',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}
