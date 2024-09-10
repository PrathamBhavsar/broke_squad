import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBillViewTextField extends StatelessWidget {
  const CreateBillViewTextField({
    super.key,
    required this.textController,
    required this.focusNode,
    this.hintText,
    this.keyboardType,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.kCreateBillTextFieldTextStyle,
      controller: textController,
      focusNode: focusNode,
      cursorColor: AppColors.grey,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: hintText,
        hintStyle: AppTextStyles.kCreateBillTextFieldTextStyle,
        focusColor: AppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
      ),
    );
  }
}
