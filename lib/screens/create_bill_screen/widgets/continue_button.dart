import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key, required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
              ),
              backgroundColor: WidgetStatePropertyAll(AppColors.kDarkColor)),
          onPressed: onPressed,
          child: Text(
            'Continue',
            style: AppTextStyles.poppins
                .copyWith(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600),
          )),
    );
  }
}