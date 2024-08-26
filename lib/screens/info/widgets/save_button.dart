import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final TextEditingController nameController;

  const SaveButton({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<InfoProvider>(
      builder: (context, infoProvider, child) {
        return GestureDetector(
          onTap: () {
            infoProvider.editUserEntry(
              nameController.text.trim(),
              'yes'

            );
          },
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: infoProvider.isLoading
                    ? Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                )
                    : CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
