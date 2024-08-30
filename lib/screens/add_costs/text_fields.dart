import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    required this.descFocusNode,
    required this.descController,
  });

  final FocusNode descFocusNode;
  final TextEditingController descController;

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
          child: Consumer(
            builder: (context, loginProvider, child) {
              return TextField(
                cursorColor: AppColors.primaryColor,
                focusNode: descFocusNode,
                controller: descController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.shopping_bag_outlined),
                  prefixIconColor: AppColors.primaryColor,
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
                  hintText: 'Description',
                  hintStyle: TextStyle(
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

class AmountTextField extends StatelessWidget {
  AmountTextField(
      {super.key,
      required this.amountFocusNode,
      required this.amountController});

  final FocusNode amountFocusNode;
  final TextEditingController amountController;

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
            focusNode: amountFocusNode,
            controller: amountController,
            decoration: InputDecoration(
                focusColor: AppColors.primaryColor,
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                prefixIconColor: AppColors.primaryColor,
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
                hintText: 'Amount',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}

class DateTextField extends StatefulWidget {
  DateTextField({
    super.key,
    required this.dateFocusNode,
    required this.dateController,
  });

  final FocusNode dateFocusNode;
  final TextEditingController dateController;

  @override
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
          child: GestureDetector(
            onTap: () => _showDateTimePicker(context),
            child: AbsorbPointer(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.primaryColor,
                controller: widget.dateController,
                focusNode: widget.dateFocusNode,
                decoration: InputDecoration(
                    focusColor: AppColors.primaryColor,
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                    prefixIconColor: AppColors.primaryColor,
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
                    hintText: 'DAte and Time',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDateTimePicker(BuildContext context) {
    // Show Date Picker Dialog
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate != null) {
        // Update selected date
        selectedDate = pickedDate;

        // Show Time Picker Dialog
        showTimePicker(
          context: context,
          initialTime: selectedTime,
        ).then((pickedTime) {
          if (pickedTime != null) {
            // Update selected time
            selectedTime = pickedTime;

            // Combine date and time
            final combinedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            // Format and update the controller text
            final formattedDateTime =
                DateFormat('yyyy-MM-dd, HH:mm').format(combinedDateTime);
            widget.dateController.text = formattedDateTime;
          }
        });
      }
    });
  }
}
