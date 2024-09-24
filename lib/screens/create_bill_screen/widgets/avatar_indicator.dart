import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/models/user.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/contact_avatar.dart';
import 'package:contri_buter/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarIndicator extends StatelessWidget {
  const AvatarIndicator({
    super.key,
    required this.context,
    required List<UserModel> selectedContacts,
    required this.firebaseContacts, // Added Firebase contact list
  }) : _selectedContacts = selectedContacts;

  final BuildContext context;
  final List<UserModel> _selectedContacts;
  final List<UserModel>
      firebaseContacts; // Firebase contacts passed from provider

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.grey,
      radius: Radius.circular(24.r),
      borderType: BorderType.RRect,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        width: getWidth(context),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
        child: _selectedContacts.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'Select Contacts',
                  style: AppTextStyles.poppins.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i <
                          (_selectedContacts.length < 5
                              ? _selectedContacts.length
                              : 5);
                      i++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ContactCircleAvatar(
                        contact: _selectedContacts[i],
                        isFirebaseContact: firebaseContacts.contains(
                          _selectedContacts[i],
                        ), // Determine if the contact is from Firebase
                      ),
                    ),
                  if (_selectedContacts.length > 5) ...[
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'more',
                      style: AppTextStyles.poppins.copyWith(
                        color: AppColors.grey,
                      ),
                    )
                  ]
                ],
              ),
      ),
    );
  }
}
