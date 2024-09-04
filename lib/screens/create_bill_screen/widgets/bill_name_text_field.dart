import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CreateBillTextField extends StatelessWidget {
  const CreateBillTextField({
    super.key,
    required TextEditingController billNameController,
    required FocusNode billNameFocusNode,
    this.hintText,
  }) : _textController = billNameController, _focusNode = billNameFocusNode;

  final TextEditingController _textController;
  final FocusNode _focusNode;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.kCreateBillTextFieldTextStyle,
      controller: _textController,
      focusNode: _focusNode,
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
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